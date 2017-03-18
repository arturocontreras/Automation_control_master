% Control de sistema de segundo orden
% por ubicación de polos
% Especificaciones de diseño:
%     r = 0.5
%     Sobreimpulso < 0%
%     Error estacionario < 0.5%
%     abs(u) <= 100
%     t_asentamiento < 1 seg
% Polos deseados:
%     p1 = -2*kf
%     p2 = -6*kf     kf = 4,  4.1, 

clear;
close all;
clc;

a0 = 1;
a1 = 5;
A = [ 0   1
      a0  a1 ];
B = [ 0
      1 ];
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
 


