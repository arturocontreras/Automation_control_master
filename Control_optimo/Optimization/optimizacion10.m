% Minimizacion de funcion
% Minimizar f(x,y) = x^4 + y^4
% Restriccion g1(x,y) = x.^2 - 1 <= 0 
% Restriccion g2(x,y) = y.^2 - 1 <= 0
% Restriccion g3(x,y) = exp(x+y) - 1 <= 0
% Las restricciones se procesaran como funciones

clear;
clc;
close all;

% Minimizacion sin restricciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y) x.^4 + y.^4
figure(1);
ezsurfc(f,[-3,3],[-3,3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Minimizacion con restriciones

f = @(x,y) x.^4 + y.^4;   % Funcion a minimizar
g1 = @(x,y) x.^2 - 1;     % Restriccion de desigualdad
g2 = @(x,y) y.^2 - 1;
g3 = @(x,y) exp(x+y) - 1;

% Definicion de funcion
fun = @(x)f(x(1),x(2));
%Valor inicial para iniciar proceso iterativo
x0 = [2 1];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');

gfun = @(x) deal([x(1).^2-1; x(2).^2-1; exp(x(1)+x(2))-1]);
% gfun = @(x) deal([x(1).^2-1; x(2).^2-1]);
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,[],[],[],[],[],[],gfun,options);

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');
