clear;
clc;
close all;

% Minimizacion sin restricciones
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Grafica de la superficie tridimensional
f = @(x,y) 1 - x + x.^2 + 0.6*y + y.^2;
figure(1);
ezsurfc(f,[0,35],[0,35]);

% Minimizacion con restriciones
% Definicion de funcion
fun = @(x) f(x(1),x(2));
g = @(x,y) -x -y + 60;
figure(2);
ezplot(g,[30,35,20,35]);       % Grafica la función g(x,y)=0
hold on;
ezcontour(f,[30,35,20,35]);       % Grafica lineas de f(x,y) para varios valores de f
%legend('Restriccion','Curvas de f(x,y)=cte');
hold off


%Valor inicial para iniciar proceso iterativo
x0 = [-1 -1]; 
options = optimset('Algorithm','interior-point','Display','iter');
A = [ -1  -1];
B = [-60];
% Minimizacion con restricion
[x,fval] = fmincon(fun,x0,A,B,[],[],[],[],[],options);

disp('  ');
disp('  ');
disp(['Solución x = [ ',num2str(x(1,1)),' ',num2str(x(1,2)),' ]']);
disp(['Valor mínimo de f(x) = ',num2str(fval)]);
disp('  ');
disp('  ');

%% Solucion con quadprog

H = [2 0
     0 2];
f = [-1 
     0.6];
 
lb = [0
       0];
options=optimset('Algorithm','interior-point-convex');
[x fval]= quadprog(H,f,A,B,[],[],lb,[],[],options)

