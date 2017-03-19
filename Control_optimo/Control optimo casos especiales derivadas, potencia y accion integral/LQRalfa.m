% LQR with prescribed degree of stability alfa > 0 
% x = exp(-alfa*t)*z
% z-system is stable (impulse response stable, in
% the worst case z = 1) 
% then, poles of x-system have real part lower
% than -alfa

clear;
clc;
close all;

n = 3;
A = [ 2   1    0
        3  -10  0
        2   1    2 ];
B = [ 0
        1
        2 ];
q1 = 1e2;  q2 = 1e1;    q3 = 1e0;
Q = diag([ q1 q2 q3 ]);
R = [ 1 ];
alfa = input('alfa: ');
Aa = A + alfa*eye(n);
P = are(Aa,B*inv(R)*B',Q);
K = inv(R)*B'*P;
Acl = A - B*K;
eig(Acl)




