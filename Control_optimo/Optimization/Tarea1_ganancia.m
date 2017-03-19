% Minimizacion de funcion
clear;
clc;
close all;
%% Minimizacion utilizando linprog
% Minimizacion con restriciones
ff = [  -10
       -8];
A = [ 0.4  0.5
      0.6  0.5];
b = [ 100
      80];
lb = [ 0
       0];
ub = [ 70
       110];
   
[x feval] = linprog(ff,A,b,[],[],lb,ub);
x
feval

%% Minimizacion utilizando fmincon
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y) -10*x-8*y;
figure(1);
ezsurfc(f,[0,100],[0,100]);

% Minimizacion con restriciones
% Definicion de funcion
fun = @(x) f(x(1),x(2));
x0 = [1 1];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,A,b,[],[],lb,ub,[],options)


