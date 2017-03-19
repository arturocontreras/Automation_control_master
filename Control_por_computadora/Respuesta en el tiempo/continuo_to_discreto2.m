clear all;close all;clc

num = [1];
den = [250 35 1];
% [r,p,k] = residue(num,den);

%%
Ts = 30;%tiempo de muestreo
Kp = 35; %Valor constante proporcional hallada anteriormente
Kz = Kp; %Controlador proporcional discreto
H = 0.1; % Ganancia del sensor
z = tf('z');

Fzoh = (1-1/z);%

sys1 =  tf(num,den);%FT de planta/s (el "s" debido al ZOH)
sys2 = c2d(sys1,Ts,'zoh');%Discretización de la planta/s

FTol = Kz*sys2*H %Funcion de transferencia discreta en lazo abierto
Numm = Kz*sys2
Denn = FTol+1

%FTcl =  ( 0.2553*z + 0.2325)/(z^2-1.716*z+0.779) % Ts = 2
%FTcl =  (0.9324*z + 0.7737)/(z^2 - 1.429*z + 0.6486) % Ts = 4
%FTcl =  ( 4.482*z + 2.812)/(z^2 - 0.59*z + 0.5278) % Ts = 10
%FTcl =  ( 11.95*z + 4.718)/(z^2 + 0.61*z + 0.5326) % Ts = 20
 FTcl =  ( 18.59*z + 4.648)/(z^2 + 1.508*z + 0.4798) % Ts = 30
%FTcl =  (33.93*z + 0.4247)/(z^2 + 3.375*z + 0.04248) % Ts = 100
[p,z] = pzmap(FTcl)
pzmap(FTcl);




