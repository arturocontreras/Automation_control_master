% Control PID por Ziegler and Nichols
% G(s) = 1/(s3+s2+16s+9)
% r = 1;
% Sobreimpulso < 1.5%
% Error estacionario = 0
% Tiempo de asentamiento < 20 segundos
% umax= 10

clear;
close all;
clc;

%fp = 0.8     fi = 0.5    fd = 0

r = 1;
fp = input('Factor proporcional : ');
fi = input('Factor integral : ');
fd = input('Factor derivativo : ');
wcr = 4;
Kcr = 7;
Tcr = 2*pi/wcr;
Kp = 0.6*Kcr*fp;
Ki = 2*Kp/Tcr*fi;
Kd = Kp*Tcr/8*fd;
a3 = 1;   a2 = 1;   a1 = 16;   a0 = 9;

numcl = [ 0  0  Kd  Kp  Ki ];
dencl = [ a3 a2 (a1+Kd) (a0+Kp) Ki ];
ti = 0;   tf = 50;   dt = 0.005;
t = ti:dt:tf;
t = t';
y = step(numcl,dencl,t);
figure(1);
plot(t,y);
title('Salida y');
grid;
maxy = max(y);
sobreimp = abs(max(y)-r)/r*100


% Señal de control u para PI (Kd = 0)
e = r - y;
numK = [ Kp Ki ];
denK = [ 1  0 ];
u = lsim(numK,denK,e,t);
figure(2);
plot(t,u);
title('Control u');
grid;

% Margen de ganancia y fase
numol = conv([0 0 0 1],[Kp Ki]);
denol = conv([1 1 16 9],[1 0]);
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


