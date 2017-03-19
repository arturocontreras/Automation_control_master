% Minimizacion de funcion
% Minimizar   f(x,y) = x^2 + y^2 - 3*x*y;
% Restriccion g(x,y) = x^2 + y^2 - 6 <= 0; 

clear;
clc;
close all;

% Minimizacion sin restricciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y) x.^2 + y.^2 - 3*x.*y;
figure(1);
ezsurfc(f,[-3,3],[-3,3]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Minimizacion con restriciones

f = @(x,y) x.^2 + y.^2 - 3*x.*y;   % Funcion a minimizar
g = @(x,y) x.^2 + y.^2 - 6;        % Restriccion de desigualdad
figure(2);
ezplot(g,[-3,3,-3,3]);       % Grafica la función g(x,y)=0
hold on;
ezcontour(f,[-3,3,-3,3]);       % Grafica lineas de f(x,y) para varios valores de f
%plot(-.9727,.4685,'ro');        % Es la solución al problema
legend('Restriccion','Curvas de f(x,y)=cte');
hold off;
grid;

% Definicion de funcion
fun = @(x) f(x(1),x(2));
%Valor inicial para iniciar proceso iterativo
x0 = [2 2];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');

gfun = @(x) deal(g(x(1),x(2)),[]);
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,[],[],[],[],[],[],gfun,options);
% [x,fval,exitflag,output] = fmincon(fun,x0,[],[],[],[],[],[],gfun,options);
% x = fmincon(fun,x0,A,B,Aeq,Beq,LB,UB,nonlcon,options);
% Restricciones: A*x <= B      Aeq*x = Beq     LB <= X <= UB

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');


