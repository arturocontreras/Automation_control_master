%clear all;close all;clc
s = tf('s');

%datos
t = ScopeData.time
entrada = ScopeData.signals.values(:,1)
salida = ScopeData.signals.values(:,2)

figure;
%modelo experimental
plot(t,entrada,'k',t,salida,'r')
hold on
%lsim(modelo,entrada,t)

%modelo 1
K =0.75;
L =0.01;
tt = 1.9;
modelo = 0.717*exp(-0.01*s)/(1+0.1*s)
lsim(modelo,entrada,t)
%T = solve('80*0.75*(1-(1+(1.9-0.01)/T)*exp(-(1.9-0.01)/T)) = 57.3780');

%modelo 2
modelo = 0.717*exp(-0.01*s)/(1+0.07*s)^2
lsim(modelo,entrada,t)

legend('Entrada','Salida real','Modelo1','Modelo2');
axis tight
grid
hold off