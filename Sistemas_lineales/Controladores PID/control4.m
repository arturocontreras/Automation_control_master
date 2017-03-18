% Control P+I
% Sistema de segundo orden.
% G(s) = 1/(s2+s+2);
% r = 5      umax = 12
% Sobreimpulso = 5%
% Error estacionario = 0%
% Tiempo de asentamiento = 14 segundos
% Margen de fase = mayor de 30 grados

clear;
close all;
clc;
r = 5;
Kp = input('Introducir Kp>0 : ');
Ki = input('Introducir Ki: (Kp+2)>Ki>0 : ');
num = [ 0  0  Kp    Ki ];
den = [ 1  1  Kp+2  Ki ];
t = 0:0.01:40;    t = t';
y = r*step(num,den,t);
numu = [ Kp  (Kp+Ki)  (2*Kp+Ki)  2*Ki ];
denu = [ 1    1       (Kp+2)   Ki];
u = r*step(numu,denu,t);
ymax = max(y);
umax = max(u);
si = (ymax-r)/r*100;
disp(['ymax = ',num2str(ymax)]);
disp(['Sobreimpulso = ',num2str(si),'%']);
disp(['umax = ',num2str(umax)]);


figure(1);
plot(t,y);  grid;
figure(2);
plot(t,u); grid;

numol = conv([0 0 1],[Kp Ki]);
denol = conv([1 1 2],[1  0]);
figure(3);
margin(numol,denol);

% Diagrama de Bode - Lazo cerrado
numcl = numol;
dencl = numol + denol;
f = 0:0.01:5;    f = f';
w = 2*pi*f;
[mag fase] = bode(numcl,dencl,w);
magdB = 20*log10(mag);
figure(4);
subplot(2,1,1);   semilogx(f,magdB);   grid;
subplot(2,1,2);   semilogx(f,fase);       grid;
