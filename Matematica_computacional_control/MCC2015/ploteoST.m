x = linspace(-2,6);
y1 = exp(x);
y2 = exp(2) + exp(2)*(x-2);
y3 = y2 + 0.5*exp(2)*(x-2).^2;
plot(x,y1,x,y2,x,y3); grid on;
legend('e^x','e^2 + e^2 (x-2)', 'Pol_2');
shg