clc, clear all, close all
tinter = [0 3000];
y1ini = 2;
y2ini = 1;
[t,Y] = ode15s(@laderVanDerPol, tinter, [y1ini; y2ini]);
plot(t,Y(:,1),'o')