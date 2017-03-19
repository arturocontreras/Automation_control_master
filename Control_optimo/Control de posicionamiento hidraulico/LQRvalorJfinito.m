% Este programa resuelve la
% ecuacion de Riccati iterativamente para un tiempo finito.

%clear; 
clc; close all;

A = [ 2   1    0
      3  -10  0
      2   1    2 ];
B = [ 0
      1
      2 ];
q1 = 1e2;  q2 = 1e1;    q3 = 1e0;
Q  = diag([ q1 q2 q3 ]);
R  = [ 1 ];

Pn = Q;

ti = 0;   dt = 0.001;    tf = 5;
t = ti:dt:tf;     t = t';
nt = length(t);
[Ak Bk] = c2d(A,B,dt);

x0 = [ 3; 1; 5];
x = x0;
J = 0;
k =1;

P(:,:,nt) = Pn;
k = nt;
for tt = tf:-dt:(ti+dt)
    Pk = P(:,:,k);
    Pp = -A'*Pk - Pk*A + Pk*B*inv(R)*B'*Pk - Q;
    P(:,:,k-1) = Pk - dt*Pp;
    %P11(k,1) = P(1,1,k);   
    k = k - 1;
end


x0 = [ 3; 1; 5];
x  = x0;
J  = 0;
k  = 1;
for tt = ti:dt:tf
   x1(k,1) = x(1,1);
   x2(k,1) = x(2,1);
   x3(k,1) = x(3,1);
   Pk = P(:,:,k);  
   u(k,1) = -inv(R)*B'*Pk*x; %(x-xast);
   %uu(k,1) = u;
   Jo(k,1)=J;
   J = J + (x'*Q*x + u(k,1)'*R*u(k,1))*dt;  
   x = Ak*x + Bk*u(k,1);   
   k = k + 1;
end
Jmin = x0'*P(:,:,1)*x0;
disp('  ');
disp('Jmin Sumatoria - Jimin Estado Inicial');
[ J  Jmin ]

figure(1);
subplot(4,1,1);    plot(t,x1);    grid;   ylabel('x1');
subplot(4,1,2);    plot(t,x2);    grid;   ylabel('x2');
subplot(4,1,3);    plot(t,x3);    grid;   ylabel('x3');
subplot(4,1,4);    plot(t,u);    grid;   ylabel('u');

figure(2);
%plot(t,Jo,'k');title('J, t finito');
plot(t,Jo,'r',t,JJ,'k');legend('Finito', 'Infinito'); title('J comparación');