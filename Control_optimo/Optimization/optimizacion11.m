% Minimizacion de funcion
% Maximizar f(x,y) = 400*x + 600*y
% Restriccion g1(x,y) = x/28 + y/14 - 1 <= 0 
% Restriccion g2(x,y) = x/14 + y/24 - 1 <= 0
% Restriccion g3(x,y) = x + y - 16 <= 0
% Restricciones:   x >=0    y>=0 

clear;
clc;
close all;

% Minimizacion con restriciones
f = [ -400
      -600 ];
A = [ 1/28  1/14
      1/14  1/24
      1     1 ];
b = [ 1
      1
      16 ];
lb = [ 0
       0 ];
ub = [ Inf
       Inf ];
   
[x feval] = linprog(f,A,b,[],[],lb,[]);
% [x feval] = linprog(f,A,b,[],[],lb,ub);     % Tambien
x
feval
