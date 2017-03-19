clear all;close all;clc

%Parametros
r = 5;%referencia
Kp= 35; %Valor de la constante proporcional de control discreto

%Tiempo de muestreo
Tcalculado = 2;
Ts = Tcalculado;
nn = 0;%Numero de periodos de muestreo de retraso

sim('Respuesta_tiempo_delay.slx'); %ejecutando el simulink que posee el diagrama de control
tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink

figure(1)
plot(tiempo,y,'b'); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')
hold on;

nn = 1;%Numero de periodos de muestreo de retraso
sim('Respuesta_tiempo_delay.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
plot(tiempo,y,'k'); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')

nn = 2;%Numero de periodos de muestreo de retraso
sim('Respuesta_tiempo_delay.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
plot(tiempo,y,'k--'); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')

nn = 3;%Numero de periodos de muestreo de retraso
sim('Respuesta_tiempo_delay.slx'); %ejecutando el simulink que posee el diagrama de control

tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
plot(tiempo,y,'r--'); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')


legend('delay=0','delay=Ts','delay=2*Ts','delay=3*Ts')






