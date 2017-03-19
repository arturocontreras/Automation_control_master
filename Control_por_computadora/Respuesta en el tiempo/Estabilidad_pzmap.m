
sys = tf(1,conv([10 1],[25 1]));
Hz = c2d(sys,5000,'zoh')
figure(1)
pzmap(Hz)
axis([-1 1 -1 1])
grid on

