% Control backstepping del sistema:
%  x1p = sin(x1) + x2
%  x2p = x1 + u
% Estado de convergencia:   x1ast, x2ast, uast
% Analizar el error en estado estacionario. Se reduce
% a medida que aumenta k1, k2 (positivos) 

clear;
clc;
close all;

k1 = input('k1 > 0: ');
k2 = input('k2 > 0: ');
ti = 0;   dt = 0.0001;   tf = 8;
 x1ast = pi/4;
 x2ast = -sqrt(2)/2;
 uast = -x1ast;
% x1ast = pi/2;
% x2ast = -1;
% uast = -x1ast;
%  x1ast = 0;
% x2ast = 0;
% uast = 0;
x1 = 1;
x2 = 1;
k = 1;
for tt = ti:dt:tf
  xx1(k,1) = x1;
  xx2(k,1) = x2;
  u = uast -x1 -(k1+cos(x1))*(sin(x1)+x2) - k2*(x2-x2ast) - k2*(k1*(x1-x1ast) + sin(x1) - sin(x1ast)); 
  % u = -(cos(x1)+k1*(x1-x1ast))*(sin(x1)+x2) - k2*(x2-x2ast) + k2*(-sin(x1)+sin(x1ast) - k1*(x1-x1ast));
  uu(k,1) = u;
  t(k,1) = tt;
  x1p = sin(x1) + x2;
  x2p = x1 + u;
  x1 = x1 + x1p*dt;
  x2 = x2 + x2p*dt;
  k = k + 1;
end
figure(1);
subplot(3,1,1);   plot(t,xx1);   grid;
subplot(3,1,2);   plot(t,xx2);   grid;
subplot(3,1,3);   plot(t,uu);    grid;

