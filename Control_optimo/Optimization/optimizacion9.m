% Minimizacion de funcion
% Maximizar f(x,y,z) = 4*x + 6*y + 2*z
% Restriccion g1(x,y,z) = 2*x + 3*y + 6*z - 20 <= 0 
% Restriccion g2(x,y,z) = 6*x + 4*y + 8*z - 28 <= 0
% Restriccion g3(x,y,z) = 6*x + 9*y + 4*z - 32 <= 0
% Restricciones:   x >=0    y>=0    z >= 0
% Las restricciones se procesaran como funciones

clear;
clc;
close all;

% Minimizacion con restriciones
f = [ -4
      -6
      -2 ];
A = [ 2  3  6
      6  4  8
      6  9  4 ];
b = [ 20
      28
      32 ];
lb = [ 0
       0
       0 ];
ub = [ Inf
       Inf
       Inf ];
   
[x feval] = linprog(f,A,b,[],[],lb,[]);
x
feval
%  x = linprog(f,A,b,Aeq,beq,LB,UB,xo,options)
% A*x <= b
% Aeq*x = beq
% LB <= x <= UB
% xo = initial point  -  Not required
% options  -   Not required

