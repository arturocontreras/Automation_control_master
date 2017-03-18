% Control de sistema
% G(s) = 1/(s2+2s)
% Para r = 5, umax = 10
% Kp = 2   Ki = 0     Kd = 0
% Sobreimpulso:  5%
% Tiempo de asentamiento = 5 seg
% Margen de fase: por lo menos 60 grados

clear;
clc;
close all;
r = 5;
umax = 10;
disp(['r = ',num2str(r)]);
Kp = input('Introducir Kp: ');
Ki = input('Introducir Ki: ');
% Kd = input('Introducir Kd: ');
ti = 0;   tf = 15;   dt = 0.005; 
t = ti:dt:tf;    t = t';
%  Control Proporcional
numy = [ 0  0  Kp ];
deny = [ 1  2  Kp ];
yp = r*step(numy,deny,t);
numu = [ Kp  (2*Kp)  0 ];
denu = [ 1  2  Kp ];
up = r*step(numu,denu,t);

%  Control PI
numy = [ 0  0  Kp  Ki ];
deny = [ 1  2  Kp  Ki  ];
ypi = r*step(numy,deny,t);
numu = [ Kp  (2*Kp+Ki)  (2*Ki)   0 ];
denu = [ 1  2  Kp  Ki ];
upi = r*step(numu,denu,t);
nt = length(t);
rr = r*ones(nt,1);
uu = umax*ones(nt,1);

figure(1);
subplot(2,1,1);  plot(t,yp,t,ypi,t,rr);
grid;
subplot(2,1,2);  plot(t,up,t,upi,t,uu);
grid;

numol = conv([0 0 1],[Kp Ki]);
denol = conv([1 2 0],[1  0]);
figure(2);
margin(numol,denol);

% Diagrama de Bode - Lazo cerrado
numcl = numol;
dencl = numol + denol;
f = 0:0.01:5;    f = f';
w = 2*pi*f;
[mag fase] = bode(numcl,dencl,w);
magdB = 20*log10(mag);
figure(3);
subplot(2,1,1);   semilogx(f,magdB);   grid;
subplot(2,1,2);   semilogx(f,fase);       grid;



