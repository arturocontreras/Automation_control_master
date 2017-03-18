%% Primer ejemplo, con A una matriz bien condicionada
rand('seed',0);
A = floor(-5 + 9*rand(5,3));
b = 1:5; b = b';
% solucion usando operador backslash
x = A\b
% solucion usando las ecuaciones normales
y = (A'*A)\(A'*b)
% solución usando la factorizacion QR reducida
[Q,R]=qr(A,0);
z = R\(Q'*b)
%% Segundo ejemplo, con A una matriz mal condicionada
% format rat
% for k = 5:10:35
%     A = hilb(k);
%     fprintf('Para n = %1d, el nro de cond es %6.4e\n',k,cond(A))
% end
format short
A = hilb(15); A = A(:,1:10);
b = 1:15; b = b';
% solucion usando las ecuaciones normales
y = (A'*A)\(A'*b);
norm(b-A*y)  % el residual
% solución usando la factorizacion QR reducida
[Q,R]=qr(A,0);
z = R\(Q'*b);
norm(b-A*z) 