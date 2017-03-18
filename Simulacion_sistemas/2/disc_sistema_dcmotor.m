
%% Modelo matemático de sistema motor DC:
clear all;close all;clc
J=0.01;
b=0.1;
K=0.01;
R=1;
L=0.005;
A = [0 1 0; 0 -b/J K/J; 0 -K/L -R/L];
B = [0; 0; 1/L];
C =  [0  1  0];
D = 0; 
nivel_c = ss(A,B,C,D);

Tm = -1/min(pole(nivel_c))/10;
Tm = floor(10000*Tm)/1000;
nivel_d = c2d (nivel_c, Tm, 'zoh');

M = idss(nivel_d.a, nivel_d.b, nivel_d.c, nivel_d.d,zeros(3,1), zeros(3,1), 'Ts', Tm)
