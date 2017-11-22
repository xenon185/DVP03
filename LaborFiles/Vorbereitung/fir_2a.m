% fir_2a.m
% FIR filter design example using the MATLAB FIR1 function 
% Autor: Nils Parche, 18.11.2017
clear all;
clc;

Fs=8e3; %Specify Sampling Frequency
Ts=1/Fs; %Sampling period.
Ns=4096; %No of time samples to be plotted.
t=[0:Ts:Ts*(Ns-1)]; %Make time array that contains Ns elements
 %t = [0, Ts, 2Ts, 3Ts,..., (Ns-1)Ts]

%create sampled sinusoids at different frequencies
f1=500; f2=1800; f3=2000; f4=3200;
x1=sin(2*pi*f1*t); x2=sin(2*pi*f2*t); x3=sin(2*pi*f3*t); x4=sin(2*pi*f4*t);
x=x1+x2+x3+x4; %Calculate samples for a 4-tone input signal
N=19; %FIR1 requires filter order (N) to be EVEN when gain = 1 at Fs/2.
% Normierte Eckfrequenz im Durchlassbereich auf Fs/2. 1800 Hz/4000Hz = 9/20
% = 0.45
% Normierte Eckfrequenz im Sperrbereich auf Fs/2. 2600 Hz/4000 Hz = 13/20 = 0.65
W=(9/20); %Specify Bandstop filter with stop band between
 %0.4*(Fs/2) and 0.6*(Fs/2)
B=fir1(N,W,'DC-1') %Design FIR Filter using default Hamming window.
correction = 32767;
B_correction =int16(B*correction) %cast B to 16 bit short Int
%create header file fir_coef.h (FIR filter coefficients)
filnam = fopen('LP_coeff.h', 'w'); % generate include-file
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


figure()
zplane(B,1)