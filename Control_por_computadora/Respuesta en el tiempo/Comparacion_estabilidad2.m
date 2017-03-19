clear all;close all;clc

%Parametros
r = 5;%referencia
Kp= 35; %Valor de la constante proporcional de control discreto

%Tiempo de muestreo
Tcalculado = 2;
Ts = Tcalculado;

sim('Respuesta_tiempo.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink

figure(1)
plot(tiempo,y,'b'); grid on;title('Salida - Temperatura �C');xlabel('tiempo');ylabel('temperatura')
hold on

Ts = 1;
sim('Respuesta_tiempo.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
plot(tiempo,y,'k');

Ts = 0.5;
sim('Respuesta_tiempo.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
plot(tiempo,y,'k--');

legend('Ts=2','Ts=1','Ts=0.5')