% Control backstepping del sistema:
%  x1p = sin(x1) + x2
%  x2p = u
% Estado de convergencia:   x1ast, x2ast, uast=0
% Converge al valor deseado

clear;
clc;
close all;

k1 = input('k1 > 0: ');
k2 = input('k2 > 0: ');
ti = 0;   dt = 0.001;   tf = 5;
x1ast = pi/4;
x2ast = -sqrt(2)/2;
% x1ast = pi/2;
% x2ast = -1;
% x1ast = 0;
% x2ast = 0;
x1 = 2;
x2 = -2;
k = 1;
for tt = ti:dt:tf
  xx1(k,1) = x1;
  xx2(k,1) = x2;
  u = -(k1+cos(x1))*(sin(x1)+x2) - k2*(x2-x2ast) - k2*(k1*(x1-x1ast) + sin(x1) - sin(x1ast)); 
  % u = -(cos(x1)+k1*(x1-x1ast))*(sin(x1)+x2) - k2*(x2-x2ast) + k2*(-sin(x1)+sin(x1ast) - k1*(x1-x1ast));
  uu(k,1) = u;
  t(k,1) = tt;
  x1p = sin(x1) + x2;
  x2p = u;
  x1 = x1 + x1p*dt;
  x2 = x2 + x2p*dt;
  k = k + 1;
end
figure(1);
subplot(3,1,1);  plot(t,xx1);
subplot(3,1,2);  plot(t,xx2);
subplot(3,1,3);  plot(t,uu);



