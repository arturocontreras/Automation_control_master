clear all;close all;clc

%Aproximación de fourier
T = 1;
%ft = 1*(t>=0 & t<0.5)+0*(t>=0.5 & t<1)
syms t x;
a0=(1/T)*int(1,t,0,0.5);
u = a0; %Término 0

for n=1:50
    an=(2/T)*int(cos(2*pi*n*t/T),t,0,0.5);
    bn=(2/T)*int(sin(2*pi*n*t/T),t,0,0.5);
    
    u = u + an*cos((2*pi/T)*n*x) + bn*sin((2*pi/T)*n*x); %sumando los términos de la serie
end

 x=0:0.01:10; 
 u_x = subs(u,x);
 plot(x,u_x)


