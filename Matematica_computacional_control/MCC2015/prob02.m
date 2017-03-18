clc, close all

% lado derecho de la EDO:
f = @(t,y) 2*t*y;  % funcion anonima
% inicializaciones
a = 1; b = 3; y0 = 1; h = 0.01;
texacto = linspace(1,3,80);
yexacto = exp(texacto.^2 - 1);

figure(1)
subplot(3,1,1) % comparacion con Euler
[t,ye] = meteuler(f,a,b,y0,h);
plot(texacto,yexacto,t,ye,'o')
axis tight, grid on

subplot(3,1,2) % comparacion con Heun
[t,yh] = metheun(f,a,b,y0,h);
plot(texacto,yexacto,t,yh,'o')
axis tight, grid on

subplot(3,1,3) % comparacion con RK4
[t,yrk4] = metrk4(f,a,b,y0,h);
plot(texacto,yexacto,t,yrk4,'o')
axis tight, grid on

figure(2)
% ploteo del error con RK4
yexacto2 = exp(t.^2 - 1);
%plot(t,abs(yh-yexacto2),'-s',t,abs(yrk4-yexacto2),'-o')
plot(t,abs(yrk4-yexacto2),'-o')
axis tight
grid on