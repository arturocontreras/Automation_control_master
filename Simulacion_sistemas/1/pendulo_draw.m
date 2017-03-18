clear all; close all; clc
L= 0.1;
g=9.81;
N=500;
dt=0.01;
v(1)= 0;
th(1)= 1;

for k = 1:N
    
th(k+1)=th(k)+v(k)*dt;
v(k+1)=v(k)-g*dt*sin(th(k+1))/L;
x(k) = L*sin(th(k));
y(k) = -L*cos(th(k));

plot(x(k),y(k), 'or',0,0, '^k')
axis([-0.12 0.12 -0.12 0.02])
line ([0 x(k)],[0 y(k)], 'Color', 'k', 'LineWidth', 2);

title('Péndulo sin amortiguamiento')
xlabel('Eje X');
ylabel('Eje Y');

text(0,0.01,strcat(num2str(th(k)),' rad'));
drawnow

end
