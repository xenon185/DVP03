% fir_2b.m
% FIR filter design example using the MATLAB FIR1 function 
% Autor: Nils Parche, 19.11.2017
clear all;
clc;

Fs=8e3; %Specify Sampling Frequency
Ts=1/Fs; %Sampling period.
Ns=2048; %No of time samples to be plotted.
F=[1800 2600]; %Cutoff frequenzcy
A=[1 0]; % Desired amplitude
RP = 0.5; % Passband ripple
RS = 40; % Stopband ripple
DEV = [(10^(RP/20)-1)/(10^(RP/20)+1)  10^(-RS/20)];

t=[0:Ts:Ts*(Ns-1)]; %Make time array that contains Ns elements
%t = [0, Ts, 2Ts, 3Ts,..., (Ns-1)Ts]
%create sampled sinusoids at different frequencies

f_step = 100:100:3900;
f_kamm = zeros(length(f_step),Ns);
x = zeros(1,length(f_kamm));


for i=1:length(f_kamm(:,1))
    for j=1:Ns
        f_kamm(i,j) = sin(2*pi*f_step(i)*t(j));
    end
    
end

x=sum(f_kamm);

% N=16; %FIR1 requires filter order (N) to be EVEN when gain = 1 at Fs/2.
% W=[0.4 0.6]; %Specify Bandstop filter with stop band between
%0.4*(Fs/2) and 0.6*(Fs/2)
[N, F0, A0, W] = firpmord(F, A, DEV, Fs)
B=firpm(N, F0, A0, W) %Design FIR Filter using default Hamming window.
%create header file fir_coef.h (FIR filter coefficients)
correction = 32767;
%B_correction =cast((B*correction),'uint16') %cast B to 16 bit short Int
B_correction = floor(B*correction);
%create header file fir_coef.h (FIR filter coefficients)
filnam = fopen('LP_coeff_firpm.h', 'w'); % generate include-file
fprintf(filnam,'#define N %d\n', N+1);
fprintf(filnam,'short h[N]={\n');
j = 0;
for i= 1:N+1;
 fprintf(filnam,' %6.0f,', B_correction(i));
 j = j + 1;
 if j >7
 fprintf(filnam, '\n');
 j = 0;
 end
end
fprintf(filnam,'};\n');
fclose(filnam);
A=1; %FIR filters have no poles, only zeros.
grid on;
freqz(B,A); %Plot frequency response - both amp and phase response.
%pause; %User must hit any key on PC keyboard to continue.
figure; %Create a new figure window, so previous one isn't lost.
subplot(2,1,1); %Two subplots will go on this figure window.
Npts=200;
%Npts=Ns;
plot(t(1:Npts),x(1:Npts)) %Plot first Npts of this 4-tone input signal
title('Time Plots of Input and Output');
xlabel('time (s)'); ylabel('Input Sig');
%Now apply this filter to the 4-tone test sequence
y = filter(B,A,x);
subplot(2,1,2); %Now go to bottom subplot.
plot(t(1:Npts),y(1:Npts)); %Plot first Npts of filtered signal.
xlabel('time (s)'); ylabel('Filtered Sig');
%pause;
figure; %Create a new figure window, so previous one isn't lost.
subplot(2,1,1);
xfftmag=(abs(fft(x,Ns))); %Compute spectrum of input signal.
xfftmagh=xfftmag(1:length(xfftmag)/2);
%Plot only the first half of FFT, since second half is mirror imag
f=[1:1:length(xfftmagh)]*Fs/Ns; %Make freq array from 0 Hz to Fs/2 Hz.
plot(f,xfftmagh); %Plot frequency spectrum of input signal
title('Input and Output Spectra');
xlabel('freq (Hz)'); ylabel('Input Spectrum');
subplot(2,1,2);
yfftmag=(abs(fft(y,Ns)));
yfftmagh=yfftmag(1:length(yfftmag)/2);
%Plot only the first half of FFT, since second half is mirror image
plot(f,yfftmagh); %Plot frequency spectrum of input signal
xlabel('freq (Hz)'); ylabel('Filt Sig Spectrum');