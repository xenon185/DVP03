
R = 1000
C = 1*10^-6
Ts = 1/8000
0

a0 = 1
a1 = R*C
b0 = 1

sys1_c = tf(b0, [a1 a0])

subplot(211)
bode(sys1_c)
subplot(212)
pzmap(sys1_c)


sys1_d = tf([(b0*Ts) (b0*Ts)], [((a0*Ts)+a1) ((a0*Ts)-a1)], Ts)

figure()
subplot(311)
bode(sys1_d)
subplot(312)
pzmap(sys1_d)
subplot(313)
impulse(sys1_d)

sys1_c2d = c2d(sys1_c,Ts)

figure()
subplot(211)
bode(sys1_c2d)
subplot(212)
pzmap(sys1_c2d)