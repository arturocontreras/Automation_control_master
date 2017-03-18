%Program 6.6 Animation program for bridge using IVP solver
%Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n, steps per point plotted p
%Calls a one-step method such as trapstep.m
%Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)
function factor = tacoma_rk_entrega_FM(inter,ic,n,p,w)
clf % clear figure window
h=(inter(2)-inter(1))/n;
y(1,:)=ic; % enter initial conds in y
t(1)=inter(1);len=6;

for i=1:n
    t(i+1)=t(i)+h;
    y(i+1,:)=runge_step(t(i),y(i,:),h,w);
    theta(i) = y(i,3);
    factor = max(theta)/ic(1,3);%el maximo general para el factor de magnificacion

end

function y=runge_step(t,x,h,w)

   k1 = ydot(t,x,w);
   g1 = x + 0.5*h*k1;

   k2 = ydot(t+0.5*h,g1,w);
   g2 = x + 0.5*h*k2;
   
   k3 = ydot(t+0.5*h,g2,w);
   g3 = x + h*k3;
   
   k4 = ydot(t+h,g3,w);
   
   y = x + (h/6)*(k1 + 2*k2 + 2*k3 + k4);

function ydot=ydot(t,y,w)
len=6;a=0.2; W=w; omega=2*pi*38/60;
a1=exp(a*(y(1)-len*sin(y(3))));
a2=exp(a*(y(1)+len*sin(y(3))));
ydot(1)=y(2);
ydot(2)=-0.01*y(2)-0.4*(a1+a2-2)/a+0.2*W*sin(omega*t);
ydot(3)=y(4);
ydot(4)=-0.01*y(4)+1.2*cos(y(3))*(a1-a2)/(len*a);
