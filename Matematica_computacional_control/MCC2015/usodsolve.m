%% parte(a)
clc
%dsolve('Dy = 2*y + t','t')
dsolve('Dy = 2*y + t','y(0)=1','t')
ezplot('(5*exp(2*t))/4 - t/2 - 1/4',[0,10]), grid on
%% parte (c)
clc
dsolve('D2y + 2*Dy = sin(x)','y(0)=-1','Dy(0)=1','x')
%% parte (d) 
clc, close all
syms x(t) y(t)
ecua1 = diff(x) == 3*x + 4*y;
ecua2 = diff(y) == -4*x+ 3*y;
% R = dsolve(ecua1,ecua2);
% xsol(t) = R.x
% ysol(t) = R.y
c1 = x(0) == 0; c2 = y(0) == 1;
[xsol(t) ysol(t)] = dsolve(ecua1,ecua2,c1,c2)
ezplot(xsol,[2,5]), hold on
ezplot(ysol,[2,5]), grid on, axis([2,5,-5*1e5,5*1e5])
legend('xsol','ysol')
hold off