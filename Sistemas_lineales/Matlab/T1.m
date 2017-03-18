clear all;close all;clc
%% Señal cuadrada desplazada
%Planta
num = [45];
den = [1 6 45];
Gs = tf(num,den);

%Señal entrada
Amp = 2;
f = 1; %Hz
offset = 1;
t = 0:0.01:10;
u = Amp*square(2*pi*f*t)+offset;
% plot(t,u)
% axis([0 10 -2 4])


%Señal de salida
y = lsim(Gs,u,t);
lsim(Gs,u,t)

