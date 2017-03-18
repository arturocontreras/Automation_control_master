clc;
f=@(x)80*0.717*(1-(1+(0.2-0.01)/x)*exp(-(0.2-0.01)/x))
j=0;
for i =0:0.01:2

j=j+1;
t(j)=i;     %tiempo
A(j)=f(i);  %magnitud
end
plot(t,A)
Xlabel('T')
Ylabel('y')
grid