% Control de sistema
% G(s) = 1/(s2+2s+2)
% Para r = 5,     umax = 10
% Sobreimpulso = 0,   Error estacionario = 0.01% 
% Tiempo de asentamiento < 7 seg.
% Margen de fase por lo menos 60 grados 
% Kp = 1   Ki = 1.4     Kd = 0
% El valor maximo de Kp se puede tomar como umax/r
% (máximo error está al inicio)

clear;
clc;
close all;
r = 5;
umax = 10;
disp(['r = ',num2str(r)]);
Kp = input('Introducir Kp: ');
Ki = input('Introducir Ki (2Kp+4>Ki): ');
% Kd = input('Introducir Kd: ');
ti = 0;   tf = 15;   dt = 0.005; 
t = ti:dt:tf;    t = t';
% Control Proporcional
numy = [ 0  0  Kp ];
deny = [ 1  2  (Kp+2) ];
yp = r*step(numy,deny,t);
numu = [ Kp  (2*Kp)  (2*Kp) ];
denu = [ 1    2    (Kp+2) ];
up = r*step(numu,denu,t);

%  Control PI
numy = [ 0  0  Kp  Ki ];
deny = [ 1  2  (Kp+2) Ki  ];
ypi = r*step(numy,deny,t);
numu = [ Kp  (2*Kp+Ki)  (2*Ki+2*Kp)  (+2*Ki) ];
denu = [ 1  2  (Kp+2)   Ki ];
upi = r*step(numu,denu,t);

nt = length(t);
rr = r*ones(nt,1);
uu = umax*ones(nt,1);
figure(1);
subplot(2,1,1);  plot(t,yp,'-r',t,ypi,'-b',t,rr);
grid;
subplot(2,1,2);  plot(t,up,'-r',t,upi,'-b',t,uu);
grid;

% Margen de ganancia:
numol = conv([0 0 1],[Kp Ki]);
denol = conv([1 2 2],[1 0]);
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




