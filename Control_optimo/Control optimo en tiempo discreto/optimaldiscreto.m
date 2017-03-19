% Este programa aplica control optimal a un
% sistema de tiempo discreto. Se resuelve la
% ecuacion de Riccati iterativamente.

clear;
clc;
close all;

A = [ 1  2
        0  3];      
  
B = [ 0
        2 ];

Q = [ 1  0
        0   0.5 ];
      
R = [ 1 ];
      
Pn = Q;

niter = 100;
P(:,:,niter) = Pn;
P11(niter,1) = Pn(1,1);

for k = (niter-1):-1:1
   Pk1 = P(:,:,k+1);
   P(:,:,k) = Q + A'*Pk1*A - A'*Pk1*B*inv(R+B'*Pk1*B)*B'*Pk1*A;
   P11(k,1) = P(1,1,k);   
end

figure(1);
plot(P11);
xlabel('Iter');
title('Matriz de Ricccati P(1,1)');

xini = [ 3
          1 ];
     
xast = [ 0
            0 ];
      
x =  xini;

for k = 1:(niter-1)
   x1(k,1) = x(1,1);
   x2(k,1) = x(2,1);
   Pk1 = P(:,:,k+1);  
   u(k,1) = -inv(R+B'*Pk1*B)*B'*Pk1*A*(x-xast);
   nk(k,1) = k-1;
   x = A*x + B*u(k,1);  
end

x =  xini;
P1 = P(:,:,1);
for k = 1:(niter-1)
   x1p(k,1) = x(1,1);
   x2p(k,1) = x(2,1);
   up(k,1) = -inv(R+B'*P1*B)*B'*P1*A*(x-xast);
   nk(k,1) = k-1;
   x = A*x + B*up(k,1);  
end

figure(2);
subplot(3,1,1);
plot(nk,x1,'-r',nk,x1p,'--b');
ylabel('x1');
subplot(3,1,2);
plot(nk,x2,'-r',nk,x2p,'--b');
ylabel('x2');
subplot(3,1,3);
plot(nk,u,'-r',nk,up,'--b');
ylabel('u');
xlabel('Iter');

for k = 1:(niter-2)
   xx  = [ x1(k,1)
             x2(k,1) ];
   xx1 = [ x1(k+1,1)
             x2(k+1,1) ];  
   Pk1 = P(:,:,k+1); 
   H(k,1) = 0.5*xx'*Q*xx + 0.5*u(k,1)*R*u(k,1) + xx1'*Pk1*xx1;
end

figure(3);
plot(H);
title('Hamiltonian H');
xlabel('Iter');
