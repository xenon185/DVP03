%Kaiser_Order_01.m
%Computation of the FIR filter order using Kaiser's formula / rch 03.03
%Ref: Ifeachor 2nd. ed., p.358
%
clear all;
clc;

fprintf('*** Filter Order ***\n');
fp = input('Type in the passband edge in Hz = ');
fs = input('Type in the stopband edge in Hz = ');
F = input('Type in the sampling frequency in Hz = ');
devp = input('Type in the maximum passband ripple (dB) = ');
devs = input('Type in the minimum stopband attenuation (db) = ');
devp = (10^(devp/20)-1);
devs = 10^(-devs/20);
num = -20*log10(min ([devp,devs]))-7.95;
den = 14.36*abs(fs-fp)/F;
N = ceil(num/den);
fprintf('Estimated filter order is %d \n',N);