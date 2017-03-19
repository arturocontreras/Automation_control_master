% Control LQR de suspensión activa de un vehículo.
% Variabes de estado:  x2v, x2, x1v, x1
% Entrada:  xo

clear;
clc;
close all;

%% Parámetros

m2 = 10;
m1 = 1;
k2 = 2*pi*1*m2;
k1 = 2*pi*8*m1;
c2 = 5;

a11 = -c2/m2;  a12 = -k2/m2;
a13 =  c2/m2;  a14 =  k2/m2;
a31 = c2/m1;   a32 = k2/m1;
a33 = -c2/m1;  a34 = -(k1+k2)/m1;
b1 = 1/m2;     b3 = -1/m1;
w3 = k1/m1;

A = [ a11  a12  a13  a14
       1    0    0    0
      a31  a32  a33  a34
       0    0    1    0 ];

B = [ b1
       0
      b3
       0 ];

W = [ 0
      0
     w3
      0 ];
  
q1 = input('Peso x2v : ');
q2 = input('Peso x2  : ');    
q3 = input('Peso x1v : ');
q4 = input('Peso x1  : ');
Q = diag([ q1  q2  q3  q4 ]);
R = [ 1 ];

w = 0.1;     % Escalón
% Tiempo de simulación 

ti = 0;    tf = 5;   dt = 0.001; 
t = ti:dt:tf;    t = t';

%% Calculo de P
Pn = Q;
nt = length(t);
P(:,:,nt) = Pn;
k = nt;

for tt = tf:-dt:(ti+dt)
    Pk = P(:,:,k);
    Pp = -A'*Pk - Pk*A + Pk*B*inv(R)*B'*Pk - Q; %Derivada de P
    P(:,:,k-1) = Pk - dt*Pp;
    P11(k,1) = P(1,1,k);   
    k = k - 1;
end

figure(1);
plot(t,P11);
title('Matriz de Riccati P(1,1)');

%% Sin control 
%Discretizacion
[Ak,Bk] = c2d(A,B,dt);
[Ak,Wk] = c2d(A,W,dt);

xini = [ 0;  0;  0;  0 ];
x =  xini;
k = 1;
for tt = ti:dt:tf
   x2vp(k,1) = x(1,1);     x2p(k,1) = x(2,1);
   x1vp(k,1) = x(3,1);     x1p(k,1) = x(4,1);
   up(k,1) = 0;
   x = Ak*x + Bk*up(k,1) + Wk*w;  
   k = k + 1;
end

%% Con control P=cte t->inf (Riccati)

x =  xini;
Pr = are(A,B*inv(R)*B',Q); %Riccati
K = inv(R)*B'*Pr;

k = 1;
for tt = ti:dt:tf
   x2v(k,1) = x(1,1);     x2(k,1) = x(2,1);
   x1v(k,1) = x(3,1);     x1(k,1) = x(4,1);
   u(k,1) = -K*x;
   x = Ak*x + Bk*u(k,1) + Wk*w;  
   k = k + 1;
end

figure(2);
subplot(2,1,1);
plot(t,x2,'-r',t,x2p,'--b');    title('Posicion x2');
subplot(2,1,2);
plot(t,x2v,'-r',t,x2vp,'--b');  title('Velocidad x2p');
figure(3);
subplot(2,1,1);
plot(t,x1,'-r',t,x1p,'--b');    title('Posicion x1');
subplot(2,1,2);
plot(t,x1v,'-r',t,x1vp,'--b');  title('Velocidad x1p');
figure(4);
plot(t,u,'-r',t,up,'--b');      title('Fuerza de Control');

%% Con control P en tiempo finito 

x =  xini;
w = 0.1;     % Escalón
k = 1;
for tt = ti:dt:tf
   x2vf(k,1) = x(1,1);     x2f(k,1) = x(2,1);
   x1vf(k,1) = x(3,1);     x1f(k,1) = x(4,1);
   Pk = P(:,:,k);  
   uf(k,1) = -inv(R)*B'*Pk*x;
   x = Ak*x + Bk*uf(k,1) + Wk*w;    
   k = k + 1;
end

figure(5);
subplot(2,1,1);
plot(t,x2,'-r',t,x2f,'--k');    title('Posicion x2');
subplot(2,1,2);
plot(t,x2v,'-r',t,x2vf,'--k');  title('Velocidad x2p');
figure(6);
subplot(2,1,1);
plot(t,x1,'-r',t,x1f,'--k');    title('Posicion x1');
subplot(2,1,2);
plot(t,x1v,'-r',t,x1vf,'--k');  title('Velocidad x1p');
figure(7);
plot(t,u,'-r',t,uf,'--k');      title('Fuerza de Control');
