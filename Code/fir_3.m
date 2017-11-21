% fir_3.m
% FIR filter design example using the MATLAB firpm function 
% Autor: Nils Parche, 19.11.2017

Fs=8e3; %Specify Sampling Frequency
Ts=1/Fs; %Sampling period.
Ns=512; %No of time samples to be plotted.
F=[500 800 2400 2700]; %Cutoff frequenzcy
A=[0 1 0]; % Desired amplitude
RP = 0.4; % Passband ripple
RS = 40; % Stopband ripple
DEV = [10^(-RS/20) (10^(RP/20)-1)/(10^(RP/20)+1) 10^(-RS/20)];

[N, F0, A0, W] = firpmord(F, A, DEV, Fs);
N = N+5;
B=firpm(N, F0, A0, W) %Design FIR Filter using default Hamming window.
%create header file fir_coef.h (FIR filter coefficients)
correction = 32767;
B_correction =uint16(B*correction) %cast B to 16 bit short Int
