clear all;close all;clc
p1 = -7.743;
p2 = -21.54;
p3 = -59.94;
c1 = 625;
syms s;
NN = (s^2+c1)
DD = expand((s-p1)*(s-p2)*(s-p3))
Gss = NN/DD

K1=0.1/(c1/(-p1*p2*p3));
K= K1;%Ganancia estática
num = K*[1 0 c1]; %Nyquist
den = [1 89223/1000 48050181/25000 24992615367/2500000];

Gs = tf(num,den)

figure(1)
bode(Gs,{1,200})
figure(2)
nyquist(Gs)