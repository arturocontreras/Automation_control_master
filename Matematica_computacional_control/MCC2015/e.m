A = [8 0;0 2]; % Example matrix
eig_A = eig(A);
flag = 0;
for i = 1:rank(A)
	if eig_A(i) <= 0 
	flag = 1;
	end
end

if flag == 1
	disp('the matrix is not positive definite')
	else
	disp('the matrix is positive definite')
end
