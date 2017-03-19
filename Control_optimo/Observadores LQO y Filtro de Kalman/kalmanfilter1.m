% Filtro de Kalman por etapas en tiempo discreto
% Sistema lineal

clear;
clc
close all;

A = [  0    0.2   0.6
        -1   -0.1   0.1
        0.3  0.2  -0.5 ];
abs(eig(A))     
W = [ 0.2
         0
         0.1 ];
C = [ 1  0  0 ];
Obs = det([ C;   C*A;   C*A*A ])
     
ti = 0;   tf = 5;   dt = 0.01;    
t = ti:dt:tf;   t = t';
nt = length(t);

% Ruido de la planta
wmean = 1;
wstd = 20;
w = randn(nt,1);
w = (w-mean(w))*wstd/std(w) + wmean;
Q = sum((w-wmean).*(w-wmean))/(nt-1);

% Ruido del sensor
nmean = 0;
nstd = 0.1;
n = randn(nt,1);
n = (n-mean(n))*nstd/std(n) + nmean;
R = sum((n-nmean).*(n-nmean))/(nt-1);

x = [ 1;  -1;  -2 ];
xh = [ -0.8;  0.5;   0.25 ];
P = diag([ 0.25   0.3   0.2 ]);    
k = 1;
for tt = ti:dt:tf
    x1(k,1)   = x(1,1);     x2(k,1) = x(2,1);       x3(k,1) = x(3,1);  
    xh1(k,1) = xh(1,1);    xh2(k,1) = xh(2,1);    xh3(k,1) = xh(3,1); 
    x = A*x + W*w(k,1);
    y = C*x + n(k,1);  
    xb = A*xh + W*wmean;
    M = A*P*A' + W*Q*W';
    P = inv(inv(M) + C'*inv(R)*C);
    L = P*C'*inv(R);
    xh = xb + L*(y - C*xb);
    k = k +1;
end
figure(1);
plot(t,x1,'-r',t,xh1,'--b');    grid;
figure(2);
plot(t,x2,'-r',t,xh2,'--b');    grid;
figure(3);
plot(t,x3,'-r',t,xh3,'--b');    grid;



    
    