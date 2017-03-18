clear all;close all;clc
u = [0 1 2 3 5]'
y = [0 3 5 7 9]'

plot(u,y)
hold on

k = (u'*y)/(u'*u);
yest = u*k;
plot(u,yest,'r')

errores = y-yest;
sec = sum(errores.^2)

%polyfit
a=polyfit(u,y,1)
plot(u,u*a(1)+a(2),'g')