% Minimización de una función sujeta a dos restricciones
% Minimizar    f(x) = x1^2 + x2^2 - 2*x1 - 2*x2 + 2
% Restriccion  g1(x) = -2*x1 - x2 + 4 <= 0
% Restriccion  g2(x) = -x1 - 2*x2 + 4 <= 0
% Gráfico de las restriccioens y de la función a minimizar
% (varios contornos para f(x) = cte)

clear;
close all;
clc;

%%%%%  RESTRICCION    %%%%%%%%%%%%%%
x1r1 = 0:0.001:4/3;
x1r1 = x1r1';
x2r1 = -2*x1r1 + 4;
x1r2 = 4/3:0.001:4;
x1r2 = x1r2';
x2r2 = (-x1r2 + 4)/2;
grafx = [ 4  4  0  4/3  4 ];
grafy = [ 0  4  4  4/3  0 ];
figure(1);
plot(x1r1,x2r1,'-b',x1r2,x2r2,'-b');
axis([ 0 4 0 4 ]); grid;
hold on;
fill(grafx,grafy,'y');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%   FUNCION  %%%%%%%%%%%%%%
for f = 0.1:0.1:1     % Varios valores para f = cte
f = f;   % Funcion  a minimizar
sqrtf = sqrt(f);
x1 = (1-sqrtf+0.001):0.001:(1+sqrtf-0.001);    % +-0.001 para asegurar el rango
x1 = x1';
x2up   = 1 + sqrt(f - (x1-1).*(x1-1));
x2down = 1 - sqrt(f - (x1-1).*(x1-1));
plot(x1,x2up,'-r','Linewidth',2);
plot(x1,x2down,'-r','Linewidth',2);
end
%%%%%%%%%%%%%%%%%%%%









