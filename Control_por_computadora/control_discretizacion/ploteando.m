%%
clear all;close all;clc
load PI_Tustin_1.mat

t = signals.time(:,1);
ref = signals.signals.values(:,1);
y = signals.signals.values(:,2);
plot(t,ref,t,y)
legend('referencia %','salida y %')
axis tight