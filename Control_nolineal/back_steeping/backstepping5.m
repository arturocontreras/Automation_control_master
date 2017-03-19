% Control backstepping del sistema
%     x1p = x1*x1 + x2
%     x2p = u
% Valores de convergencia  x1ast, x2ast=-x1ast^2, uast = 0 

clear;
clc;
close all;

k1 = input('k1: ');
k2 = input('k2: ');
ti = 0;   dt = 0.001;   tf = 5;
x1ast = 1;
x2ast = -1;
x1ast = 2;
x2ast = -4;
% x1ast = 0;
% x2ast = 0;
x1 =  0.1;
x2 = -0.1;
k = 1;
for tt = ti:dt:tf
  xx1(k,1) = x1;
  xx2(k,1) = x2;
  % u = -2*x1^3 - (k1+k2)*x1^2 - (k1+k2)*x2 - k1*k2*x1 - 2*x1*x2;
  u = -(2*x1+k1)*(x1*x1+x2) - k2*(x2-x2ast) - k2*(x1*x1 - x1ast*x1ast) - k1*k2*(x1-x1ast); 
  uu(k,1) = u;
  t(k,1) = tt;
  x1p = x1*x1 + x2;
  x2p = u;
  x1 = x1 + x1p*dt;
  x2 = x2 + x2p*dt;
  k = k + 1;  
end
figure(1);
subplot(3,1,1);   plot(t,xx1);    grid;
subplot(3,1,2);   plot(t,xx2);    grid;
subplot(3,1,3);   plot(t,uu);     grid;

