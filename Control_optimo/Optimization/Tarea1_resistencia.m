% Minimizacion de funcion
clear;
clc;
close all;

% Minimizacion con restriciones
f = @(x,y) 50*x + 40*y;   % Funcion a minimizar
g1 = @(x,y) 2*10e6/x-1.6e4;     % Restriccion de desigualdad
g2 = @(x,y) 1.6*10e6/y-1.6e4;

% x>=0 , y>=0
lb = [ 0 
       0];
   
% Definicion de funcion
fun = @(x)f(x(1),x(2));
%Valor inicial para iniciar proceso iterativo
x0 = [100 100];
options = optimset('Algorithm','interior-point','Display','iter');

gfun = @(x) deal([2*10e6/x(1)-1.6e4 ;1.6*10e6/x(2)-1.6e4]);

% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,[],[],[],[],lb,[],gfun,options);

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');