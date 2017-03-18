function dydt = laderVanDerPol(t,y)
dydt = zeros(2,1);

dydt(1) = y(2);
dydt(2) = 1000*(1-y(1)^2)*y(2) - y(1);

% o equivalentemente:
%dydt = [y(2); 1000*(1-y(1)^2)*y(2) - y(1)];
end