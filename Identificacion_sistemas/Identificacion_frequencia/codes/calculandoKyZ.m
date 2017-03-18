clear all;close all;clc
w=[2.78 40] ;
Gdb=[-28 -52]; 
G= 10.^(Gdb/20);

num=w.^2;
den=sqrt((w.^2+7.743^2).*(w.^2+21.54^2).*(w.^2+59.94^2));
razon1=den(2)/den(1);
x=((G(1)/G(2))^2)/razon1^2;

z1=sqrt((w(2)^2*x-w(1)^2)/(1-x))

