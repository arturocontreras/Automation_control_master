clear all;close all;clc

var = [];
Tprbs = 0.01;
tensy = 100;

%Amplitud mínima y máxima de la PRBS
%dentro de la zona lineal%%%%%%%%%%

disp('%%%%%%%PRBS%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('Introducir valores de amplitud dentro de la zona lineal')
disp('')
umax = input('Amplitud máxima :' );
umin = input('Amplitud mínima :' );

%%%%%%% Periodo mínimo y maximo de la señal pseudoaleatoria %%%%%
%%%%%% en función a su tiempo de establecimiento %%%%%%%

Test = input('Tiempo de establecimiento del proceso a modelar : ');

Ts = Test/40;
Tmax = (2*pi*Ts)/0.15;
Tmin = (2*pi*Ts)/5;

Tmax = round(Tmax*100);
Tmin = round(Tmin*100);
Tpulso = Tmin + Tmax + 100;
 
for k = 1:tensy
    porc = round(rand*1000);
    if porc>Tmax porc=Tmax;
    elseif porc>Tmin porc = Tmin;
    end
    vec = [ones(porc,1) ; zeros(Tpulso -porc,1)];
    var = [var; vec];

end

u = (umax - umin)*var+umin;
t = (0:Tprbs:Tpulso-Tprbs)';

figure;plot(t,u);
axis([0 tensy umin-1 umax+1])
simin1 = [t u];


    
    
    
    
    

