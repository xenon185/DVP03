N=23; %FIR1 requires filter order (N) to be EVEN when gain = 1 at Fs/2.
% Normierte Eckfrequenz im Durchlassbereich auf Fs/2. 1800 Hz/4000Hz = 9/20
% = 0.45
% Normierte Eckfrequenz im Sperrbereich auf Fs/2. 2600 Hz/4000 Hz = 13/20 = 0.65
W=(9/20); %Specify TP filter with stop band
B=fir1(N,W,'DC-1') %Design FIR Filter using default Hamming window.
correction = 32767; % Correction for 16-bit integer normalized 1
B_correction =int16(B*correction) %cast B to 16 bit short Int
%create header file fir_coef.h (FIR filter coefficients)
