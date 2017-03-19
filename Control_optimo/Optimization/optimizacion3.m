% Minimizacion de funcion
% f = x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;
% Primero: Sin restricciones. Uso de comado fminunc().
% Segundo: Con restriccion g = x.*y/2+(x+2).^2+(y-2).^2/2-2 <= 0; 
%                Uso del comando fmincon().

clear;
clc;
close all;

% Minimizacion sin restricciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y)  x.*exp(-x.^2-y.^2) + (x.^2+y.^2)/20;
figure(1);
ezsurfc(f,[-2,2],[-2,2]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicion de funcion
fun = @(x) f(x(1),x(2));
%Valor inicial para iniciar proceso iterativo
x0 = [-0.5; 0];
% Opciones del algoritmo
options = optimset('LargeScale','off');
% 'Largscale' requiere la inclusion de derivadas
options = optimset(options,'Display','iter');
% Para visualziar los resultados de cada iteracion

% Minimizacion sin restricciones (unconstrained minimization)
[x fval] = fminunc(fun,x0,options);
%[x, fval, exitflag, output] = fminunc(fun,x0,options);
disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(2,1)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('----------------------------------');

disp('ENTER para Minimizacion con restricciones ')
pause;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Minimizacion con restriciones
% Contornos de la funcion y de las restricciones 
f = @(x,y) x.*exp(-x.^2-y.^2)+(x.^2+y.^2)/20;   % Funcion a minimizar
g = @(x,y) x.*y/2+(x+2).^2+(y-2).^2/2-2;        % Restriccion de desigualdad
figure(2);
ezplot(g,[-6,0,-1,7]);       % Grafica la función g(x,y)=0
hold on;
ezcontour(f,[-6,0,-1,7]);       % Grafica lineas de f(x,y) para varios valores de f
plot(-.9727,.4685,'ro');        % Es la solución al problema
legend('Restriccion','Curvas de f(x,y)=cte','Mínimo');
hold off;
grid;

% Proceso de minimizacion
%Valor inicial para iniciar proceso iterativo
x0 = [-2 1];
% Parametros del algortimo de optimizacion
% Algoritmo a utilizar:  de punto interior
% Display: Mostrar iteraciones en pantalla  
options = optimset('Algorithm','interior-point','Display','iter');

gfun = @(x) deal(g(x(1),x(2)));
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

