% Grafica de una funcion con minimos y maximos locales

clear;
clc;
close all;

x = -15:0.01:10;
x = x';
y = 0.02*x.^4 + 0.25*x.^3 - 2.5*x.*x - 15*x;
figure(1);
plot(x,y,'-b','Linewidth',2);
xlabel('Eje X');
ylabel('Eje Y');
title('y = 0.025*x.^4 + 0.25*x.^3 - 2.5*x.*x - 15*x');
grid;




