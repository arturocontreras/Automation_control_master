
%% Analisis 2 
clc
close all
A=m1.A;
B=m1.B;
C=m1.C;
D=m1.D;
% Compute the actual transfer function
[num,den] = ss2tf(A,B,C,D)
sys_dis = tf(num,den,Ts)

sys_con = d2c(sys_dis,'zoh')
pole(sys_con)
figure(1)
nyquist(sys_con)
t=0:0.5:100000;
t=t(1:length(u1));

figure(2)
% lsim(sys_dis,u1,t,'b');
subplot(211)
lsim(sys_con,u1,t);
subplot(212)
%u2 = -7*heaviside(t)-heaviside(t-10)
u2 = 10*heaviside(t)+5*heaviside(t-100);
lsim(sys_con,u2,t)
%step(sys_con)
% hold off


