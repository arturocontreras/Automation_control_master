clear all;clc
%Matriz Anxm
n= input('numero filas =');
m= input('numero columnas =');

for i = 1:n
   for k = 1: m
       A(i,k) = round(rand(1));
   end
end

for i = 1:n
   for k = 1: m
       if(i>=k)
       B(i,k) = 1;
       else
       B(i,k) = 0;
       end
   end
end

for i = 1:n
   for k = 1: m
       if k ==1 | k==m | i==k
       C(i,k) = 1;
       else
       C(i,k) = 0;
       end
   end
end

A
B
C