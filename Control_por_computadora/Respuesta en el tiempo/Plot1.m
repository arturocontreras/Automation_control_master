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

Lmin = 1.05*y(end);
Lmax = 0.95*y(end);
Mp = 1.2*y(end);
Tss = 40;

figure(1)
% subplot(311)
% plot(tiempo,y); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')
% subplot(312)
% plot(tiempo,err); grid on;title('Error en Voltios');xlabel('tiempo');ylabel('V')
% subplot(313)
% plot(tiempo,ref); grid on;title('Referencia Voltios');xlabel('tiempo');ylabel('V')

plot(tiempo,y); grid on;title('Salida - Temperatura °C');xlabel('tiempo');ylabel('temperatura')
hold on
plot(tiempo,ones(1,length(tiempo))*Lmax,'r')
plot(tiempo,ones(1,length(tiempo))*Lmin,'r')
plot(tiempo,ones(1,length(tiempo))*Mp,'b--')
plot([Tss Tss],[0 60],'k--')