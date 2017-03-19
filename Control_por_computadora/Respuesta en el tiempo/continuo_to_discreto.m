clear all;close all;clc

num = [1];
den = [250 35 1];
% [r,p,k] = residue(num,den);

%%
Ts = 2;%tiempo de muestreo
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

%FTcl =  ( 0.3647*z + 0.3322)/(z^2 - 1.705*z + 0.789) % Ts = 2
%FTcl =  (1.332*z + 1.105)/(z^2 - 1.389*z + 0.6817) % Ts = 4
%FTcl =  ( 6.403*z + 4.017)/(z^2 - 0.3979*z + 0.6483) % Ts = 10
%FTcl =  ( 17.07*z + 6.74)/(z^2 + 1.122*z + 0.7348) % Ts = 20
FTcl =  ( 22.08*z + 6.932)/(z^2 + 1.758*z + 0.7234) % Ts = 25
%FTcl =  (48.48*z + 0.6068)/(z^2 + 4.829*z + 0.06068) % Ts = 100
[p,z] = pzmap(FTcl);
pzmap(FTcl);




%FTcl = (Kz*Fzoh*sys2)/(1+Kz*Fzoh*sys2*H)
%syms z
%vpa(expand((z-exp(-0.1*2))*(z-exp(-0.04*2))*(z-1)))



