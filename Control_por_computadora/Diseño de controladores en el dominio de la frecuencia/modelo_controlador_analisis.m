clear all;close all;clc

G1s = tf([10],[1 10]);
G2s = tf([1],[1 1]);
Gs = series(G1s,G2s);
Hz = 10; % 10VDC/1mxs
T = 0.02;%periodo de muestreo
Dz = 1;%Calculado para MF = 90
rr = 1; %referencia escalon

Gz = c2d(Gs,T)
GHz  = Dz*Gz*Hz; %FT Lazo abierto

figure(1)
margin(GHz); grid

figure(2)
% dbode(GHz,[],T); grid
%Respuesta del sistema sin controlador a un escalón
[y, t] = step(GHz,10)
ref = ones(1,length(y));
plot(t,y,'-r',t,ref,'-b')
grid on
legend('salida','referencia')


% figure(3)
% % dbode(GHz,[],T); grid
% %Respuesta del sistema sin controlador a un escalón
% GHzcl = feedback(GHz,1)
% [y, t] = step(GHzcl,10)
% ref = ones(1,length(y));
% plot(t,y,'-r',t,ref,'-b')
% grid on
% legend('salida lazo cerrado','referencia')
% 
% % Controlador
% Kp = 0.8511;%
% Ti = 1.4472;
% z = tf('z',T);
% w = (2/T)*((z-1)/(z+1))
% Dz = Kp*(1+1/(Ti*w));
% DGHz = Dz*GHz;
% 
% figure(4)
% FTz = feedback(Dz*Gz,Hz);%FT lazo cerrado
% [y, t] = step(FTz,10)
% ref = ones(1,length(y));
% plot(t,y,'-r',t,ref/Hz,'-b')
% grid on
% legend('salida lazo cerrado + D(z)','referencia')
% 
% figure(5)
% margin(DGHz)

sim('modelo2.mdl'); %ejecutando el simulink que posee el diagrama de control
tt = tiempo(:,1);
yy = y(:,2); 
ref = r(:,2)/Hz;
uu = u(:,2);
posicion = pos(:,2);

Mp = (max(yy)-rr/Hz)*100/(rr/Hz)

figure(3)
subplot(211)
plot(tt,ref,'k'); grid on;title('salida');xlabel('tiempo');ylabel('V')
hold on
plot(tt,yy,'b');
hold off
subplot(212)
plot(tt,posicion,'b');





