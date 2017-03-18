clear all;clc
N=input('numero real = ')

if N<0
flag1 = 1;
rcubo = -abs(N)^(1/3);
rcubo_round = round(-abs(N)^(1/3));
else
flag1 = 0;
rcubo = N^(1/3);
rcubo_round = round(N^(1/3));
end


if rcubo ==rcubo_round
flag2 = 1;
else
flag2 = 0;
end

if flag1 && flag2
disp('ambos')  
elseif flag1
disp('cumple1 es negativo')  
elseif flag2
disp('cumple2 es cubo perfecto-')     
end
