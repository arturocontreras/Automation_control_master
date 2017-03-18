clc
x = linspace(-3,4,80);
y = sin(2*x) .* exp(-x/2) ./ (x.^2 + 1);
plot(x,y)
grid on
xlabel('x (en s)')
ylabel('y (en m/s)')
title('mi primer')
   
