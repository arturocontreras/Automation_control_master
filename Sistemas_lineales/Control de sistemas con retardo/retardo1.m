% Efecto del retardo sobre la señal de realimentacion y.
% Se realimenta y(t-tau).
% Grafica la respuesta al escalón y el diagrama de Nyquist. 
% En ambos casos, los retardos de estabilidad límite deben
% ser iguales (tau = 0.418 seg). 

clear;
clc;
close all;

b0 = 1;
a2 = 1;  a1 = 2;  a0 = 5;
numG = [ b0 ];
denG = [ a2 a1 a0 ];
Kp = 6;
tau = input('tau: ');
dt = 0.001;
ntau = round(tau/dt);
if(ntau == 0)     % Se da un punto adicional para el caso en que tau = 0. 
    ntau = 1;
end

yy = zeros(ntau,1);
y = 0;    yp = 0;
ti = 0;   dt = 0.001;   tf = 12;
tt = ti:dt:tf;     tt = tt';
nt = length(tt);
r = 0.5*ones(nt,1);
titau = ti-tau;
k = 1;
for t = ti:dt:tf
 %   yout(k,1) = y;
    ytau = yy(k,1);
    ytaut(k,1)= ytau;
    u = Kp*(r(k,1) - ytau);
    y2p = (-a1*yp - a0*y + b0*u)/a2;
    y = y + yp*dt;
    yp = yp + y2p*dt;
    yy(ntau+k,1) = y;
    k = k + 1;
end
yout = yy(ntau:nt+ntau-1,1);
figure(1);
plot(tt,yout);    grid;


% Diagrama de Nyquist de lazo abierto
w = 0:0.05:200;   w = w';
j = sqrt(-1);
s = j*w;
G = Kp*b0./(a2*s.*s + a1*s + a0).*exp(-s*tau);
Greal = real(G);
Gimag = imag(G);
figure(2);
plot(Greal,Gimag);    grid;
  




