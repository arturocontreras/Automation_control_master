clear all;close all;clc
%% Se�al pulso entrada a la planta Gs
%Planta
num = [45];
den = [1 6 45];
Gs = tf(num,den);

%Se�al de entrada en el tiempo - lsim
t = 0:0.01:10;
u = 2*(heaviside(t-1)-heaviside(t-3));
% plot(t,u)
% axis([0 5 0 4])

%Se�al de entrada en frecuencia - Laplace
syms s;
uf = 2*(exp(-s)-exp(-3*s))/s;

%Se�al de salida tiempo
y = lsim(Gs,u,t);
figure(1)
subplot(211)
lsim(Gs,u,t)
title('Salida utilizando lsim')

%Se�al de salida en frecuencia
Gsf = 45/(s^2+6*s+45);
yf = Gsf*uf
yft = ilaplace(yf) %Transformada inversa de laplace para obtener la salida
yft=subs(yft) %reemplazando el valor de tiempo - t
subplot(212)
plot(t,yft)
title('Salida utilizando Laplace')
