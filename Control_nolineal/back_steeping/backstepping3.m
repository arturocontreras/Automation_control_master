% Control backstepping del sistema
%    x1p = x1*x1 + x2
%    x2p = x3
%    x3p = u
% Estabilización x* = [0 0 0 ]   u*=0

clear;
clc;
close all;

k1 = input('k1: ');
k2 = input('k2: ');
k3 = input('k3: ');
ti = 0;   dt = 0.001;   tf = 5;
x1 =  1;
x2 = -1.5;
x3 =  -1;
k = 1;
for tt = ti:dt:tf
  xx1(k,1) = x1;
  xx2(k,1) = x2;
  xx3(k,1) = x3;
  r = x3 + k2*(x2 + x1*x1 + k1*x1) + (2*x1+k1)*(x1*x1 + x2);  
  u = -k3*r -k2*x3 - (k2*(2*x1+k1)+(2*x1*x1+2*x2)+(2*x1+k1)*2*x1)*(x1*x1+x2) -(2*x1+k1)*x3;
  uu(k,1) = u;
  t(k,1) = tt;
  x1p = x1*x1 + x2;
  x2p = x3;
  x3p = u;
  x1 = x1 + x1p*dt;
  x2 = x2 + x2p*dt;
  x3 = x3 + x3p*dt;
  k = k + 1;
end
subplot(4,1,1);   plot(t,xx1);
subplot(4,1,2);   plot(t,xx2);
subplot(4,1,3);   plot(t,xx3);
subplot(4,1,4);   plot(t,uu);


