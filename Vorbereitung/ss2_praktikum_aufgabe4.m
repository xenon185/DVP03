%% Laborbericht SS2P-2

% Labor:        Signale & Systeme 2
% Laborgruppe:  SS2P-2
% Professor:    A. Rauscher-Scheibe
% Datum:        03.10.2016
% Gruppen:      Nils Parche (2210363) 

%% Aufgabe 4
% Parameter
R = 1*10^3;
C1 = 1*10^-6*10^3;
L = 100;
TA = 0.1;

% Konstanten
T1 = R * C1;
T22 = L * C1;

%% Systeme im kontinuierlichen
% Uebertragungsfunktion der Systeme
sys1 = tf([1],[T1 1]);
sys2 = tf([1],[T22 T1 1]);

% Impulse und Sprungantwort
% Pol-Nullstellen-Diagramm
figure()
subplot(221)
impulse(sys1, sys2);
legend('sys1_k','sys2_k');
subplot(222)
step(sys1, sys2);
legend('sys1_k','sys2_k');
subplot(223)
pzmap(sys1);
legend('sys1_k')
sgrid()
subplot(224)
pzmap(sys2)
legend('sys2_k')
sgrid()

%% Systeme im diskreten

% Konstanten
A = T1 / (T1 + TA);
B = TA / (T1 + TA);
C = (-2*T22-T1*TA)/(T22+T1*TA+TA*TA);
D = (T22)/(T22+T1*TA+TA*TA);
E = (TA*TA)/(T22+T1*TA+TA*TA);

% Uebertragungsfunktion der Systeme
sys1d = tf([B],[1 -A],TA);
sys2d = tf([E],[1 C D],TA);

% Impulse und Sprungantwort
% Pol-Nullstellen-Diagramm
figure()
subplot(221);
impulse(sys1d, sys2d);
legend('sys1_d','sys2_d');
subplot(222);
step(sys1d,sys2d)
legend('sys1_d','sys2_d');
subplot(223);
pzmap(sys1d)
legend('sys1_d');
subplot(224);
pzmap(sys2d)
legend('sys2_d');

%% Kontinuierlich to Diskret, Matlab-Funktion c2d

% Uebertragungsfunktion der Systeme
sys1d_c2d = c2d(sys1, TA, 'foh');
sys2d_c2d = c2d(sys2, TA, 'foh');

% Impulse und Sprungantwort
figure()
subplot(211)
impulse(sys1d_c2d, sys2d_c2d)
legend('sys1_d_c2d', 'sys2_d_c2d');
subplot(212)
step(sys1d_c2d, sys2d_c2d)
legend('sys1_d_c2d', 'sys2_d_c2d');


%% Aperiodischer Grentfall
% Parameter
R = 0.4*10^3;
C1 = 1*10^-6*10^3;
L = 100;
TA = 0.1;

% Konstanten
T1 = R * C1;
T22 = L * C1;

% Uebertragungsfunktion 
sys2 = tf([1],[T22 T1 1]);

subplot(311)
impulse(sys2)
legend('sys2');
subplot(312)
step(sys2)
legend('sys2');
subplot(313)
pzmap(sys2)
legend('sys2');

%% Schwingung
% Parameter
R = 10;
C1 = 0.001;
L = 100;
TA = 0.1;

% Konstanten
T1 = R * C1;
T22 = L * C1;

% Uebertragungsfunktion 
sys2 = tf([1],[T22 T1 1]);

subplot(311)
impulse(sys2)
legend('sys2');
subplot(312)
step(sys2)
legend('sys2');
subplot(313)
pzmap(sys2)
legend('sys2');