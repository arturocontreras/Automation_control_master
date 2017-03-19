% Minimizacion de funcion
% Minimizar f(x,y) = x^2 + y^2 - 2*x - 2*y + 2
% Restriccion g1(x,y) = -2*x - y + 4 <= 0 
% Restriccion g2(x,y) = -x - 2*y + 4 <= 0
% Las restricciones se expresaran en la form a AX < B 

clear;
clc;
close all;

% Minimizacion sin restricciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y) x.^2 + y.^2 - 2*x - 2*y + 2;
figure(1);
ezsurfc(f,[-3,3],[-3,3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Minimizacion con restriciones

f = @(x,y) x.^2 + y.^2 - 2*x - 2*y + 2;   % Funcion a minimizar
g1 = @(x,y) -2*x - y + 4;        % Restriccion de desigualdad
g2 = @(x,y) -x - 2*y + 4;
figure(2);
ezplot(g1,[0,4,0,4]);       % Grafica la función g(x,y)=0
hold on;
ezplot(g2,[0,4,0,4]);
ezcontour(f,[0,4,0,4]);       % Grafica lineas de f(x,y) para varios valores de f
grid;
legend('Restriccion','Curvas de f(x,y)=cte');
hold off;

% Definicion de funcion
fun = @(x) f(x(1),x(2));
%Valor inicial para iniciar proceso iterativo
x0 = [-1 -1];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');
A = [ -2  -1
      -1  -2 ];
B = [ -4
       -4 ];
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,A,B,[],[],[],[],[],options);
% [x,fval,exitflag,output] = fmincon(fun,x0,[],[],[],[],[],[],gfun,options);
% x = fmincon(fun,x0,A,B,Aeq,Beq,LB,UB,nonlcon,options);
% Restricciones: A*x <= B      Aeq*x = Beq     LB <= X <= UB

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');


