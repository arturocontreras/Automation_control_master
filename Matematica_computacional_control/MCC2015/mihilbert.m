clc
n = 15;
A = hilb(n);
fprintf('determinante de A es: %10.8e\n',det(A))
fprintf('nro de condicionamiento es: %10.8e\n',cond(A))
b = A * ones(n,1);
x = A\b