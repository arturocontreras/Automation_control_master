clear all;close all;clc
n=7;
N=2^n-1;
A= [1 0 0 0 0 0 1];
u(1:8,1)=[0 0 0 0 0 0 0 1];

for k=9:N
        u(k) = rem(A(1)*u(k-1)+A(2)*u(k-2)+A(3)*u(k-3)+A(4)*u(k-4)+...
            A(5)*u(k-5)+A(6)*u(k-6)+A(7)*u(k-7)+1,2);
       
end

u=20*u+65;
figure(1)
plot(u)

%metodo de matlab
uid = idinput(127,'prbs',[0 1],[65 85])
hold on
plot(uid,'--r')
axis tight