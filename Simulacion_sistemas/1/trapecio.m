function th = trapecio(t, t1, t2, af)
u = @heaviside;
th= (u(t)-u(t-t1)).*(0)+...
(u(t-t1)-u(t-t2)).*(af*pi/180*(t-t1)/(t2-t1))+...
u(t-t2)*af*pi/180;
end

