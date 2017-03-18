clc, close all
% definimos los lados derechos del sistema
f = @(t,x,y) -x + x*y;  % para x'(t)
g = @(t,x,y) y - x*y;   % para y'(t)
% definimos parámetros
a = 0; b = 50; x0 = 0.3; y0 = 2; h = 0.01;
% resolvemos numéricamente usando Met. Euler
%[t,x,y] = meteuler2d(f,g,a,b,x0,y0,h);
[t,x,y] = metrk4_2d(f,g,a,b,x0,y0,h);
% ploteo de x vs t, y vs t
subplot(1,2,1)
plot(t,x,'r',t,y,'-.b'),grid on, axis tight
legend('x(t) tib.','y(t) tort.')
xlabel('t : tiempo en años')
subplot(1,2,2)
comet(x,y), grid on
plot(x,y), grid on
xlabel('x = tib. en cientos')
ylabel('y = tort. en cientos')