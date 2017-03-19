clear all;close all;clc

%% Parametros
Kpi = 0.014;
Ti = 0.25;

Kpe = 0.26;

J = 0.02;
beta = 0.065;

Kf = 20;
tau =0.2;

T = 0.04;

sim('ControlPC_lab2.slx'); %ejecutando el simulink que posee el diagrama de control
t = y.time;
y = y.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
%err = Error.signals.values(:,1);
ref = r(:,2);
tu = u.time;
u_ext = u.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink

figure(1)
plot(t,ref,'k'); grid on;title('salida');xlabel('tiempo');ylabel('F')
hold on
plot(t,y,'b');
hold off

figure(2)
plot(tu,u_ext,'k'); grid on;title('Señal control externa');xlabel('tiempo');ylabel('u')
