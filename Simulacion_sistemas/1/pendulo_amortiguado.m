clear all; close all; clc
L= 0.1;
g=9.81;
N=500;
c = 0.005; %coeficiente de amortiguamiento
dt=0.01;
v(1)= 0;
th(1)= 0.5;

for k=1:N
th(k+1)=th(k)+v(k)*dt;
v(k+1)=(1-c)*v(k)-g*dt*sin(th(k+1))/L;
x(k) = L*sin(th(k));
y(k) = -L*cos(th(k));
clf
figure(1)
subplot(2,1,2)
hold on
plot(0,0, '^r')
plot(x(k),y(k), 'ok')
plot([0 x(k)],[0 y(k)])
axis([-0.12 0.12 -0.12 0.02])
subplot(2,1,1)
hold on
plot(th, 'k')
plot(v,  'r')
axis([0  500 -5 5])
pause(0.01)
end

