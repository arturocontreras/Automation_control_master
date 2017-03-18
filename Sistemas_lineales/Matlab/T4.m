clear all;close all;clc
%% Generación de función de entrada con amplitud, frecuencia y ancho variable
%Ingreso de parámetros:

Vmax = input('Ingresa Vmax = ');
Vmin = input('Ingresa Vmin = ');
Pon =input('Ingresa %ON = ');
f = input('Ingresa frecuencia =');
N =input('Ingresa numero de periodos =');

%Calculando parametros deducidos
T =1/f;%Periodo
tmax = N*T;%Tiempo final
t = 0:0.001:tmax; %creación de tiempos discretos
Ton =Pon*T/100; %Tiempo en alto
u =0;

for n=1:N
u = u + Vmax*(t>=(n-1)*T & t<Ton+(n-1)*T)+Vmin*(t>=Ton+(n-1)*T & t<n*T);
end
plot(t,u)
axis tight
%axis([0 10 -4 4])

%Planta
num = [45];
den = [1 6 45];
Gs = tf(num,den);

%Señal de salida
y = lsim(Gs,u,t);
lsim(Gs,u,t)
