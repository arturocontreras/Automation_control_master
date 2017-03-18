% Simulacion para los siguientes casos:
% Control PI sin retado
% Control PI con retardo de la salida
% Control PI con Predictor de Smith y retardo en la slaida
% Digarma de Nyquist de control PI lazo abierto
% Valor límite del retardo para Kp=12 y Ki=9 es tau=0.7635:
% Se puede analizar el desempeño del Predictor de Smith:
%    a) Variación de parámetros de la planta
%    b) Distinto estado inicial
%    c) Distinto valor del retardo tau.

clear;
clc;
close all;

b0 = 2; b1 = 1;
a0 = 9; a1 = 5; a2 = 3; a3 = 1;
numG = [ b1 b0 ];
denG = [ a3 a2 a1 a0 ];
Kp = 0.1;
Ki = 0.9;

%%%%%%%%%%%%%%%%%%%%
%%% Simulacion sin retardo. Control PI
y = 0;    yp = 0; y2p=0; up=0; ua=0;
ti = 0;   dt = 0.001;   tf = 50;

tt = ti:dt:tf;     tt = tt';
nt = length(tt);
r = 0.5*ones(nt,1);
interr = 0;
k = 1;
for t = ti:dt:tf
    yy(k,1)= y;
    err = r(k,1) - y;
    interr = interr + err*dt;
    u = Kp*err + Ki*interr;
    y3p = (-a2*y2p - a1*yp - a0*y + b0*u+b1*up)/a3;
    y   =   y  + yp*dt;     %y(k)
    yp  =  yp  + y2p*dt;    %yp(k)
    y2p =  y2p + y3p*dt;    %y2p(k)
    k = k + 1;
end
figure(1);
plot(tt,yy);    grid;
title('Salida sin retardo. Control PI');

%%%%%%%%%%%%%%%%%%
%%% Simulacion con retardo. Control PI
tau = input('tau: ');
dt = 0.001;
ntau = round(tau/dt);
if(ntau == 0)     % Se da un punto adicional para el caso en que tau = 0. 
    ntau = 1;
end
yy = zeros(ntau,1);

y = 0;    yp = 0; y2p=0; up=0; y3p=0; ua=0;
ti = 0;   dt = 0.001;   tf = 50;
tt = ti:dt:tf;     tt = tt';
nt = length(tt);
r = 0.5*ones(nt,1);
interr = 0;
k = 1;
for t = ti:dt:tf
    ytau = yy(k,1);
    err = r(k,1) - ytau;
    interr = interr + err*dt;
    u = Kp*err + Ki*interr;
    y3p = (-a2*y2p - a1*yp - a0*y + b0*u+b1*up)/a3;
    y   =   y  + yp*dt;     %y(k)
    yp  =  yp  + y2p*dt;    %yp(k)
    y2p =  y2p + y3p*dt;    %y2p(k)
    yy(ntau+k,1) = y;
    k = k + 1;
end
yout = yy(ntau:nt+ntau-1,1);
figure(2);
plot(tt,yout);    grid;
title('Salida con retardo. Control PI');

%%%%%%%%%%%%%%%%%%
%%% Control PI con Predictor de Smitth
ntau = round(tau/dt);
if(ntau == 0)     % Se da un punto adicional para el caso en que tau = 0. 
    ntau = 1;
end
yy = zeros(ntau+20,1);   % Retardo en la salida
y = 0;    yp = 0; y2p=0; up=0; y3p=0; ua=0;
yc = 0;  ypc = 0;  y2pc=0; y3pc=0;  % Estado inicial modelo  
yyc = zeros(ntau,1);   % Retardo a considerar en el control  
ti = 0;   dt = 0.001;   tf = 50;
tt = ti:dt:tf;     tt = tt';
nt = length(tt);
r = 0.5*ones(nt,1);
interr = 0;
k = 1;
for t = ti:dt:tf
 %   yout(k,1) = y;
    ytau = yy(k,1);
    ytaut(k,1)= ytau;
    yest = yc - ytau + yyc(k,1);
    yestim(k,1) = yest;
    err = (r(k,1) - yest);
    interr = interr + err*dt;
    u = Kp*err + Ki*interr;
    y3p = (-a2*y2p - a1*yp - a0*y + b0*u+b1*up)/a3;
    y   =   y  + yp*dt;     %y(k)
    yp  =  yp  + y2p*dt;    %yp(k)
    y2p =  y2p + y3p*dt;    %y2p(k)
    yy(ntau+k,1) = y;
%%%%

    y3pc = (-a2*y2pc - a1*ypc - a0*yc + b0*u+b1*up)/a3;
    yc = yc + ypc*dt;
    ypc = ypc + y2pc*dt;
    y2pc =  y2pc + y3pc*dt;    %y2p(k)

    yyc(ntau+k,1) = yc;    
    k = k + 1;
end
yout = yy(ntau:nt+ntau-1,1);
figure(3);
plot(tt,yout,'-b',tt,yestim,'--r');    grid;
title('Salida con retardo, Control PI y predictor de Smith');

%w = -30:0.07:30;   w = w';
w = 0.005:0.005:200;   w = w';
j = sqrt(-1);
s = j*w;
GN = (Kp+Ki./s).*((b1.*s+b0)./(a3.*s.*s.*s + a2*s.*s + a1*s + a0)).*exp(-s*tau);
GNreal = real(GN);
GNimag = imag(GN);
figure;
plot(GNreal,GNimag);    grid;
title('Diagrama de Nyquist PI con retardo');



