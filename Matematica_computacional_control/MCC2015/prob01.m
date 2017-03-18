clc, clear t y, close all
% parámetros
r = 2.2; k = 100;
% definir el lado der. de la EDO:
f = @(t,P) r*P*(1-P/k); % anonymous function
% parametros adicionales
a = 0; b = 1.5; h = 0.001;
hold on
for i=10:10:200
   [t,y] = meteuler(f,a,b,i,h);
   plot(t,y)
end
grid on, axis tight
hold off