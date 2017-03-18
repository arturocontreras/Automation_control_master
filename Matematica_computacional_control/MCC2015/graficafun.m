clc, close all
x = linspace(-10,1,80);
y = linspace(-10,0.5,80);
[X,Y] = meshgrid(x,y);
%f = @(x,y) (x.^2 + y).^2 +3*y.^2;
f = @(x,y) 2*x.^3+x.*y.^2+5*x.^2+y.^2;

Z = f(X,Y);
niveles = 0:0.05:2;
surf(X,Y,Z), hold on
% contour3(X,Y,Z,niveles,'LineWidth',1.5)
% subplot(1,2,2)
% contour(X,Y,Z,niveles)
