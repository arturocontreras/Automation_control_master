%clear all;close all;clc
s = tf('s');
t = ScopeData.time
entrada = ScopeData.signals.values(:,1)
salida = ScopeData.signals.values(:,2)
figure;
subplot(221)
plot(t,entrada,t,salida)
axis tight
grid
subplot(222)
modelo = 0.75*exp(-0.01*s)/(1+0.5*s)
lsim(modelo,entrada,t)
axis tight
grid
K =0.75;
L =0.01;
tt = 1.9;
T = solve('80*0.75*(1-(1+(1.9-0.01)/T)*exp(-(1.9-0.01)/T)) = 57.3780');
subplot(222)
modelo = 0.75*exp(-0.01*s)/(1+0.5*s)
lsim(modelo,entrada,t)
axis tight
grid
