% Control PID por Ziegler and Nichols
% G(s) = 1/(s3+s2+16s+9)
% r = 1;
% Sobreimpulso < 1.5%
% Error estacionario = 0
% Tiempo de asentamiento < 20 segundos
% umax= 10

clear;
close all;
clc;

kp = 0.6;
ki = 0.2;
kd = 0;

%200/(s3+20s2+100s+200)

num = [ 0  0 0 200];
den = [ 1  20 100 200];
G = tf(num,den);
C = tf([kd kp ki],[1 0 0]);
%C = pid(1.68,2.139,0);
pidtool(G);

