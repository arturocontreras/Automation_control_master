% Este programa aplica control optimal a un
% sistema de tiempo discreto. Se resuelve la
% ecuacion de Riccati iterativamente.

clear;
clc;
close all;

A = [ 0  1
      0  0];      % Sistema tipo integrador
  
B = [ 0
      4 ];

Q = [ 20  0
      0   20 ];
      
R = [ 1 ];
      
Pn = Q;

ti = 0;    tf = 4;   dt = 0.0005; 
t = ti:dt:tf;    t = t';
nt = length(t);

P(:,:,nt) = Pn;
k = nt;
for tt = tf:-dt:(ti+dt)
    Pk = P(:,:,k);
    Pp = -A'*Pk - Pk*A + Pk*B*inv(R)*B'*Pk - Q;
    P(:,:,k-1) = Pk - dt*Pp;
    P11(k,1) = P(1,1,k);   
    k = k - 1;
end

figure(1);
plot(P11);
title('Matriz de Riccati P(1,1)');
Pric = are(A,B*inv(R)*B',Q);

xini = [ 3
         1 ];
     
xast = [ 0
         0 ];
      
x =  xini;

[Ak,Bk] = c2d(A,B,dt);

k = 1;
for tt = ti:dt:tf
   x1(k,1) = x(1,1);
   x2(k,1) = x(2,1);
   Pk = P(:,:,k);  
   u(k,1) = -inv(R)*B'*Pk*(x-xast);
   x = Ak*x + Bk*u(k,1);  
   k = k + 1;
end

x =  xini;
P1 = P(:,:,1);
K = inv(R)*B'*P1;
k = 1;
for tt = ti:dt:tf
   x1p(k,1) = x(1,1);
   x2p(k,1) = x(2,1);
   up(k,1) = -K*(x-xast);
   x = Ak*x + Bk*up(k,1);  
   k = k + 1;
end
figure(2);
subplot(3,1,1);
plot(t,x1,'-r',t,x1p,'--b');
ylabel('x1');
subplot(3,1,2);
plot(t,x2,'-r',t,x2p,'--b');
ylabel('x2');
subplot(3,1,3);
plot(t,u,'-r',t,up,'--b');
ylabel('u');
xlabel('Tiempo');
k = 1;
for tt = ti:dt:tf
   xx  = [ x1(k,1)
           x2(k,1) ];
   xx1 = A*xx + B*u(k,1); 
   Pk = P(:,:,k); 
   H(k,1) = 0.5*xx'*Q*xx + 0.5*u(k,1)*R*u(k,1) + xx'*Pk*xx1;
   k = k + 1;
end

figure(3);
plot(t,H);
title('Hamiltonian');
xlabel('Tiempo [seg]');
