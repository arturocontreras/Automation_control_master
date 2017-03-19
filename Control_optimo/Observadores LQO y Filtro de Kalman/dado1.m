clear;
clc;
close all;
kmax = 30000;
cont1 = 0;  cont2 = 0;  cont3 = 0;
cont4 = 0;  cont5 = 0;  cont6 = 0;
for k = 1:kmax
x = rand(1,1);
x = 5.9999*x + 0.5;
x = round(x);
if(x == 1)
    cont1 = cont1 + 1;
elseif(x == 2)
    cont2 = cont2 + 1;
elseif(x == 3)
    cont3 = cont3 + 1;    
elseif(x == 4)
    cont4 = cont4 + 1;
elseif(x == 5)
    cont5 = cont5 + 1;
elseif(x == 6)
    cont6 = cont6 + 1;
end
end
cont = [ cont1  cont2  cont3  cont4  cont5  cont6 ];
prob = cont/kmax;
dado = [ 1 2 3 4 5 6 ];
figure(1);
bar(dado,prob);

