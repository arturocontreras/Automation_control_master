%clear all;close all;clc
clc
%% Parametros
Kpi = 0.014;
Ti = 0.25;

%Kpe = 1;

J = 0.02;
beta = 0.065;

Kf = 20;
tau =0.2;

%% FTs

Gm = tf([1],[J beta]); %modelo de la maquina
Gci =tf([Kpi*Ti Kpi],[Ti 0]); %controlador de lazo interno
GM = feedback(Gci*Gm,1); %Lazo interno

pole(GM) %Polos del lazo interno
%demGM = [0.005 0.01975 0.014];
%roots(demGM)

Gf = tf([Kf],[tau 1]); %Fuerza de corte, tasa de alimentacion
Gmf = GM*Gf; %FT lazo abierto
T = 0.04; % Tiempo de discretizacion (tau_min /5 --> 0.2/5 = 0.04)

%% Lugar de las raices
Hz = 1
Kpe =  0.26;

GHz = Gmf*Hz;
[numLA denLA]=c2d(GHz,T,'zoh'); %discretizacion
FTZ = tf(Kpe*numLA , denLA , T)%--> funcion de transferencia lazo abierto discreta
figure(1)
rlocus(FTZ)

%% Diagrama de Bode
figure(2)
dbode(Kpe*numLA , denLA , T)
[Gm,Pm,Wgm,Wpm] = margin(FTZ) 
MF = Pm
MG = 20*log10(Gm)
grid on

figure(3)
dnyquist(Kpe*numLA , denLA , T)
grid on


