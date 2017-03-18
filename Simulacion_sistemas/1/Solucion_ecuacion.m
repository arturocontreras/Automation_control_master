clear all;clc
ff = @(x)x^2-4*x+4;
dff =@(x)2*x-4;
x_ant = -10;
y = ff(x_ant);

while abs(y) > 10^(-5)
    
    x = x_ant - dff(x_ant)/ff(x_ant);
    y = ff(x);
    x_ant = x;
    
end

x
