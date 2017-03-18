clear all;close all;clc

Kp = 0.1;
Ki = 0.9;


s = tf('s')
G = (s+2)/(s^3+3*s^2+5*s+9);
%K = 10 + 12/s;
K = Kp + Ki/s;

FT = G*K/(1+G*K);
step(FT/2)