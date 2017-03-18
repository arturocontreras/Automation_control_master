clear all;close all;clc

m=1;
k=40;
c=2;
num = [c k]; %Nyquist
den = [m c k];

Gs = tf(num,den)

figure(1)
bode(Gs)
figure(2)
nyquist(Gs)