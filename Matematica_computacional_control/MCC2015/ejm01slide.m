function [t,y] = ejm01slide()
tinter = [0 9];
y0 = 10;

[t,y] = ode45(@lader,tinter,y0);
plot(t,y)

function dydt = lader(t,y)
alfa = 2; gama = 1e-3;
dydt = alfa*y - gama*y^2;
end

end