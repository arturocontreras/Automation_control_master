% r = 0.5
% t_asentamiento < 4 seg
% sobreimpulso   < 1%
% error estacionario: 0%
% abs(u) < 50 volt
% pot < 250 watts
% Probar diferentes leyes de control (para diferetes ubicaciones de polos)

clear;
close all;
clc;
R = 1.1;            L = 0.0001;
Kt = 0.0573;        Kb = 0.05665;
I = 4.326e-5;       p = 0.0025;
m = 1.00;           c = 40;
r = 0.01;           alfa = 45*pi/180;
d = m + 2*pi*I*tan(alfa)/(p*r);
a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;

A = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
B = [ 0
      0
      b31 ];
Wf = [ 0
       w21       
       0 ];     
 
Fseca = 0*1.2;   % Probar factor de 0 a 1 para variar intensidad de fricción seca

kf = input('Factor Kf de los polos: ');
p1 = -2*kf;
p2 = -6*kf;   
k1 = a0 + p1*p2;
k2 = a1 - (p1+p2);
K = [ k1 k2 ];
Acl = A - B*K;
eig(Acl)

ti = 0;   tf = 2;    dt = 0.001;
[ Ak Bk ] = c2d(A,B,dt);
k = 1;
x(1,1) = 0;
x(2,1) = 0;
r = 0.5;
for tt = ti:dt:tf
    xx1(k,1) = x(1,1);
    xx2(k,1) = x(2,1);
    u = -k1*(x(1,1) - r) - k2*x(2,1);
    uu(k,1) = u;
    ti(k,1) = tt;
    x = Ak*x + Bk*u;
    k = k + 1;
end
figure(1);
plot(ti,xx1);
figure(2);
plot(ti,xx2);
figure(3);
plot(ti,uu);
 












