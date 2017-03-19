% Minimización de una función sujeta a una restricción
% Minimizar    f(x) = x1^2 + x2^2 - 3*x1*x2
% Restriccion  g(x) = x1^2 + x2^2 - 6 <= 0
% Gráfico de la restricción y de la función a minimizar
% (varios contornos para f(x) = cte)

clear;
close all;
clc;

%%%%%  RESTRICCION    %%%%%%%%%%%%%%
sqrt6 = sqrt(6);
x1r = -sqrt6:0.0001:sqrt6;
x1r = x1r';
x2rup   = sqrt(6 - x1r.*x1r);
x2rdown = -sqrt(6 - x1r.*x1r);
figure(1);
fill(x1r,x2rup,'-c',x1r,x2rdown,'-c');
axis([-4 4 -4 4 ]); grid;
hold on;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%   FUNCION  %%%%%%%%%%%%%%
for f = 5:-1:-5
f = f;   % Funcion a minimizar
x1 = 0:0.0005:4;
x1 = x1';
nx1 = length(x1);
x2up = 3*x1 + sqrt(5*x1.*x1 + 4*f);
x2up = x2up/2;
x2down = 3*x1 - sqrt(5*x1.*x1 + 4*f);
x2down = x2down/2;
a = (imag(x2up) == 0);   % Determinando los términos con parte imaginaria
[ b c ] = max(a);        % Determinando los términos con parte imaginaria
kreal = c;               % Determinando los términos con parte imaginaria
x1 = x1(kreal:nx1,1);    
x2up = x2up(kreal:nx1,1);      % Tomando solo los terminos reales   
x2down = x2down(kreal:nx1,1);  % Tomando solo los terminos reales

x1n = -x1;
x2upn = 3*x1n + sqrt(5*x1n.*x1n + 4*f);
x2upn = x2upn/2;
x2downn = 3*x1n - sqrt(5*x1n.*x1n + 4*f);
x2downn = x2downn/2;
plot(x1,x2up,'-r','Linewidth',2);
plot(x1,x2down,'-r','Linewidth',2);
plot(x1n,x2upn,'-r','Linewidth',2);
plot(x1n,x2downn,'-r','Linewidth',2);
end
%%%%%%%%%%%%%%%%%%%%









