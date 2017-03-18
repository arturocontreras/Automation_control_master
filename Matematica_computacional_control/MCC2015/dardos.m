clc
n = 1e5;  % nro de tiros
x = -1 + 2*rand(n,1);
y = -1 + 2*rand(n,1);
exitos = 0;
figure
axis([-1 1 -1 1])
axis equal off
hold on
plot(x,y,'.b')
for k = 1:n
    if x(k)^2 + y(k)^2 <=1
        exitos = exitos + 1;
    end
end
teta = linspace(0,2*pi,80);
xc = cos(teta);
yc = sin(teta);
plot(xc,yc,'r','LineWidth',1.5)
hold off
aproxpi = 4*exitos/n;
fprintf('Estimado de pi = %15.13f\n',aproxpi)
fprintf('pi correcto    = %15.13f\n',pi)