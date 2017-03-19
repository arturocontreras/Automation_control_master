% LQR with prescribed degree of stability alfa > 0 
% x = exp(-alfa*t)*z
% z-system is stable (impulse response stable, in
% Determinación del valor minimo de J
% Jimin = xo' P xo

clear;
clc;
close all;

A = [ 2   1    0
        3  -10  0
        2   1    2 ];
B = [ 0
        1
        2 ];
q1 = 1e2;  q2 = 1e1;    q3 = 1e0;
Q = diag([ q1 q2 q3 ]);
R = [ 1 ];
P = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*P;

ti = 0;   dt = 0.001;    tf = 5;
t = ti:dt:tf;     t = t';
[Ak Bk] = c2d(A,B,dt);

x0 = [ 3; 1; 5];
x = x0;
J = 0;
k =1;
for tt = ti:dt:tf

   x1(k,1) = x(1,1);
   x2(k,1) = x(2,1);
   x3(k,1) = x(3,1);
   u = -K*x;
   uu(k,1) = u;
   J = J + (x'*Q*x + u'*R*u)*dt;  
   x = Ak*x + Bk*u;   
   k = k + 1;
end
Jmin = x0'*P*x0; 
disp('  ');
disp('Jmin Sumatoria - Jimin Estado Inicial');
[ J  Jmin ]

figure(1);
subplot(4,1,1);    plot(t,x1);    grid;   ylabel('x1');
subplot(4,1,2);    plot(t,x2);    grid;   ylabel('x2');
subplot(4,1,3);    plot(t,x3);    grid;   ylabel('x3');
subplot(4,1,4);    plot(t,uu);    grid;   ylabel('u');

