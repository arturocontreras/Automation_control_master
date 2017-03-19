% Integracion de tres sensores usando Filtro de Kalman.
% Para la variacion de la temperatura se genera un ruido
% filtrado (pasa bajo) que luego se deriva para generar Tp.
% Se calcula la varianza de Tp (w) para ser usada en el filtro
% de Kalman,

clear;
clc;
close all;

ti = 0;   dt = 0.01;   tf = 30;
t = ti:dt:tf;   t = t';
nt = length(t);
% Generacion de ruido (filtrado) de variacion de T
sigmarT = 0.5;
rT = sigmarT*randn(nt,1);
a = 1;   % Filtro pasa bajo
rfilt = 0;
k = 1;
for tt = 1:nt
   rf(k,1) = rfilt;
   rfilt = (1-a*dt)*rfilt + a*rT(k,1)*dt;
   k = k + 1;
end
rf = 10*rf;
figure(1);
plot(t,rT,t,rf);   grid;     
title('Ruido filtrado con valor medio cero');

x = 20;    % Temperatura media
T = x + rf;
figure(2);
plot(t,T); grid;
title('Temperatura con valor medio 20');

T(nt+1,1) = T(nt);    % Punto adicional para que Tp tenga nt puntos 
Tp = diff(T)/dt;
figure(3);
plot(t,Tp);   grid;
title('Derivada de la Temperatura Tp');
w = Tp-mean(Tp);
sigmaw = std(Tp);   % Desviacion estandar de la derivada de T (Tpunto) 

A = [ 0 ];
C = [ 1; 1; 1];
sigmaw = sigmaw;
Q = [ sigmaw*sigmaw ];
sensigma1 = 0.4;
sensigma2 = 0.4;
sensigma3 = 0.4;
R = diag([sensigma1^2  sensigma2^2  sensigma3^2 ]);
S = are(A',C'*inv(R)*C,Q);     % Riccati Equation
L = S*C'*inv(R);

w = w;    % Tp generado anteriormente
ruido1 = sensigma1*randn(nt,1);
ruido2 = sensigma2*randn(nt,1);
ruido3 = sensigma3*randn(nt,1);

xh = x + (ruido1(1,1) + ruido2(1,1) + ruido3(1,1))/3;

k = 1;
for tt = ti:dt:tf
    xx(k,1) = x;
    xxh(k,1) = xh;
    y = [ x + ruido1(k,1)
            x + ruido2(k,1)
            x + ruido3(k,1) ];
    sensor1(k,1) = y(1,1);
    sensor2(k,1) = y(2,1);    
    sensor3(k,1) = y(3,1); 
    sensorsuma(k,1) = (y(1,1)+y(2,1)+y(3,1))/3;
    xhp = A*xh + L*(y - C*xh);
    xh = xh + xhp*dt;  
    xp = A*x + w(k,1);
    x = x + xp*dt;
    k = k + 1;
end    

figure(4);
plot(t,xx,'-r',t,xxh,'-b',t,sensorsuma,'-k',t,sensor1,'--g',t,sensor2,'--y',t,sensor3,'--m');
grid;
title('Comparación de Temperaturas');

% Error de estimacion
ekalman = xxh-xx;
esuma = sensorsuma - xx;
esensor1 = sensor1 - xx;
figure(5);
plot(t,ekalman,'-b',t,esuma,'--k',t,esensor1,'--g');
grid;
title('Comparación de Errores de Estimación');

stdkalman = std(ekalman);
stdsuma = std(esuma);
stdsensor1 = std(esensor1);
disp(['STD error Kalman :  ',num2str(stdkalman)]);
disp(['STD error Suma    :  ',num2str(stdsuma)]);
disp(['STD error Sensor1:  ',num2str(stdsensor1)]);






