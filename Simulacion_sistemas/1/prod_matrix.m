function C = prod_matrix( A,B )

size_A = size(A)
na = size_A(1)
ma = size_A(2)

size_B = size(B)
nb = size_B(1)
mb = size_B(2)
%condición ma = nb
if ma == nb
    disp('OK')
else 
    disp('No se puede operar')
    return;
end
%tamaño de C = 
C= zeros(na,mb)


for i=1:na
    for k = 1:mb
        for g = 1:ma
        C(i,k) = C(i,k) + A(i,g)*B(g,i)
        end
    end
end

