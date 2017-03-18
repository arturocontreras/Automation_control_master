clc, close all
x = linspace(0,2*pi);
for n = 1:8
   y = sin(n*x);
   plot(x,y)
   grid on
   title(sprintf('Grafica de y = sen(%1dx)',n))
   axis tight
   pause(0.8)
end
