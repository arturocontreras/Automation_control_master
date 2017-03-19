% Este programa aplica control optimal a un
% sistema de tiempo continuo. Se resuelve la
% ecuacion de Riccati iterativamente.

clear;
clc;
close all;

A = [ 0  1
        1  2 ];
  
B = [ 0
        4 ];

Q = [ 10  0
         0   1 ];
      
R = [ 1 ];
      
Pn = Q;

ti = 0;
tf = 4;
dt = 0.0001;
t = ti:dt:tf;
t = t';
nt = length(t);

P = 1*Pn;

k = nt;
for tt = tf:-dt:ti
   Pk1(:,:,k) = P;
   P11(k,1) = P(1,1);  
   Pp = -(A'*P + P*A - P*B*inv(R)*B'*P + Q);
   P = P - dt*Pp;
   k = k - 1;
end

figure(1);
plot(t,P11);   ylabel('Solucion Riccati');
xlabel('Tiempo');

xini = [ 3
         1 ];
      
xast = [  0
          0 ];
       
[Ak,Bk] = c2d(A,B,dt);       
       
x =  xini;

for k = 1:nt
   x1(k,1) = x(1,1);
   x2(k,1) = x(2,1);
   Pk = Pk1(:,:,k);  
%   Pk = P(:,:,1);
   u(k,1) = -inv(R)*B'*Pk*(x-xast);
   H(k,1) = 0.5*x'*Q*x + 0.5*u(k,1)*R*u(k,1) + x'*Pk*(A*x + B*u(k,1)); 
   x = Ak*x + Bk*u(k,1);  
end

figure(2);
subplot(3,1,1);
plot(t,x1);   ylabel('x1');
subplot(3,1,2);
plot(t,x2);   ylabel('x2');
subplot(3,1,3);
plot(t,u);    ylabel('u');
xlabel('Tiempo');
figure(3);
plot(t,H);  ylabel('Hamiltonian');
xlabel('Tiempo');
