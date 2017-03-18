function [t,x,y] = meteuler2d(f,g,a,b,x0,y0,h)
% resuelve EDO: y'=f(t,y), C.I: y(a)=y0
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
t(1) = a; x(1)= x0; y(1) = y0;
for n = 1:nmax
   t(n+1) = t(n) + h;
   x(n+1) = x(n) + h*f(t(n),x(n),y(n));
   y(n+1) = y(n) + h*g(t(n),x(n),y(n));
end

