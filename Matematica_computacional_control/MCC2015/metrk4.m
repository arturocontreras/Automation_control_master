function [t,y] = metrk4(f,a,b,y0,h)
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
t = zeros(1,nmax + 1); y = t;
t(1) = a; y(1) = y0;
for n = 1:nmax
   t(n+1) = t(n) + h;
   k1 = f(t(n),y(n));
   k2 = f(t(n) + 0.5*h, y(n) + 0.5*h*k1);
   k3 = f(t(n) + 0.5*h, y(n) + 0.5*h*k2);
   k4 = f(t(n) + h, y(n) + h*k3);
   y(n+1) = y(n) + h/6*(k1 + 2*k2 + 2*k3 + k4);
end
end 
