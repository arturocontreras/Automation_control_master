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
err = Error.signals.values(:,1);
ref = Referencia.signals.values(:,1);

figure(1)
plot(tiempo,err,'b'); grid on;title('Error en Voltios');xlabel('tiempo');ylabel('V')
hold on
error1 = err(end)

Ts = Tcalculado+2;
sim('Respuesta_tiempo.slx'); %ejecutando el simulink que posee el diagrama de control
tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
err = Error.signals.values(:,1);
plot(tiempo,err,'k');
error2 = err(end)


Ts = Tcalculado+6;
sim('Respuesta_tiempo.slx'); %ejecutando el simulink que posee el diagrama de control
tiempo = Salida.time;
y = Salida.signals.values(:,1); %Variables guardadas en los SCOPE de Simulink
err = Error.signals.values(:,1);
plot(tiempo,err,'k--');
error3 = err(end)

legend('Ts=2','Ts=4','Ts=8')
