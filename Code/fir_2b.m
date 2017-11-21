% fir_2b.m
% FIR filter design example using the MATLAB firpm function 
% Autor: Nils Parche, 19.11.2017

Fs=8e3; %Specify Sampling Frequency
Ts=1/Fs; %Sampling period.
Ns=512; %No of time samples to be plotted.
F=[1800 2600]; %Cutoff frequenzcy
A=[1 0]; % Desired amplitude
RP = 0.5; % Passband ripple
RS = 40; % Stopband ripple
DEV = [(10^(RP/20)-1)/(10^(RP/20)+1)  10^(-RS/20)];

[N, F0, A0, W] = firpmord(F, A, DEV, Fs);
N = N+2; % Korrektur der Filterkoeffizienten um die Sperrdaempfung zu erreichen
B=firpm(N, F0, A0, W) %Design FIR Filter using default Hamming window.
correction = 32767;
%B_correction =cast((B*correction),'uint16') %cast B to 16 bit short Int
B_correction = floor(B*correction);
