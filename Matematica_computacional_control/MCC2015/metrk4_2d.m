function [t,x,y] = metrk4_2d(f,g,a,b,x0,y0,h)
% resuelve EDO: x'=f(t,x,y), 
%               y'=g(t,x,y), C.I: y(a)=y0
% input:
%   f : lado derecho de la EDO
%  a,b: intervalo donde se resolverá la EDO
%   y0: condicion inicial
%    h: tamaño de paso
% output:
%    t: arreglo para el tiempo
%    y: arreglo para la solucion numérica

% nro max de iteraciones
nmax = ceil((b-a)/h);
% inicializaciones
t = zeros(1,nmax + 1); x = t; y = t;
t(1) = a; x(1) = x0; y(1) = y0;
for n = 1:nmax
   t(n+1) = t(n) + h;
   k1x = f(t(n),x(n),y(n));
   k1y = g(t(n),x(n),y(n));
   k2x = f(t(n) + 0.5*h, x(n) + 0.5*h*k1x, y(n) + 0.5*h*k1y);
   k2y = g(t(n) + 0.5*h, x(n) + 0.5*h*k1x, y(n) + 0.5*h*k1y);
   k3x = f(t(n) + 0.5*h, x(n) + 0.5*h*k2x, y(n) + 0.5*h*k2y);
   k3y = g(t(n) + 0.5*h, x(n) + 0.5*h*k2x, y(n) + 0.5*h*k2y);
   k4x = f(t(n) + h, x(n) + h*k3x, y(n) + h*k3y);  
   k4y = g(t(n) + h, x(n) + h*k3x, y(n) + h*k3y);
   x(n+1) = x(n) + h/6*(k1x + 2*k2x + 2*k3x + k4x);
   y(n+1) = y(n) + h/6*(k1y + 2*k2y + 2*k3y + k4y);
end