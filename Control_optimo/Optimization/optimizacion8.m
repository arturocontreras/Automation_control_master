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

f  = @(x,y,z) -4*x - 6*y - 2*z;   % Funcion a minimizar

% Definicion de funcion
fun = @(x) f(x(1),x(2),x(3));
%Valor inicial para iniciar proceso iterativo
x0 = [-1 0 -1];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');

A = [ 2  3  6
      6  4  8
      6  9  4
     -1  0  0
      0 -1  0
      0  0 -1 ];
B = [ 20
      28
      32
       0
       0
       0 ];
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,A,B,[],[],[],[],[],options);

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ',num2str(x(1,3)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');
