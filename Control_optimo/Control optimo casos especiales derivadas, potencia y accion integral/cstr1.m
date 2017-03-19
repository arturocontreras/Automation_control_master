% CSTR
% Dos tanques con concentración C1 y C2
% Se quiere controlar la concetración C2
% a partir de la concetración de entrada C0

clear;
clc;
close all;

F = 0.090;    % m3/min
V1 = 1.35;    % m3
V2 = 0.95;
K1 = 0.08;    % 0.04 porciento/min
K2 = 0.12;
a11 = -(F + K1*V1)/V1;
a21 = F/V2;
a22 = -(F + K2*V2 )/V2;
b1 = F/V1;
A = [ a11    0
        a21  a22 ];
B = [ b1 0
        0 ];
C = [ 0  1 ];
D = [ 0 ];
ti = 0;      tf = 100;       dt = 0.01;
t = ti:dt:tf;   t = t';
nt = length(t);
q1 = input('q1  [0]: ');
q2 = input('q2  [1e5]: ');
Q = diag([ q1 q2 ]);
R = [ 1 ];
P = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*P;
k1 = K(1,1);     k2 = K(1,2);
r = 0.5;
C0max = 3;

[ Ak Bk ]  = c2d(A,B,dt);
% [ Ak Wk ] = c2d(A,Wf,dt);
x = [ 0;  0 ];     % Vector de estado inicial
k = 1;
for tt = ti:dt:tf
   C1(k,1) = x(1,1);
   C2(k,1)  = x(2,1);
   u = -K*(x - [ 0;  r ]);
   if( u > C0max)
       u = C0max;
   elseif(u < -C0max)
       u = -C0max;
   end
   C0(k,1) = u;
   x = Ak*x + Bk*u;
   k = k+1;
end

figure(1);
subplot(3,1,1);   plot(t,C1);
subplot(3,1,2);   plot(t,C2);
subplot(3,1,3);   plot(t,C0);


% Con accion integral de (C2 - r)

Ai = [ a11    0    0
         a21  a22   0
          0      1    0 ];
Bi = [ b1 
         0
         0 ];
q1 = input('q1  [0]: ');
q2 = input('q2  [9800]: ');
q3 = input('q3  [200]: ');
Qi = diag([ q1 q2  q3 ]);
Ri = [ 1 ];
Pi = are(Ai,Bi*inv(Ri)*Bi',Qi);
Ki = inv(Ri)*Bi'*Pi;
k1i = Ki(1,1);     k2i = Ki(1,2);    k3i = Ki(1,3);

% [ Ak Wk ] = c2d(A,Wf,dt);
x = [ 0;  0 ];     % Vector de estado inicial
k = 1;
interr = 0;
for tt = ti:dt:tf
   C1i(k,1) = x(1,1);
   C2i(k,1)  = x(2,1);
   interr = interr + (x(2,1) - r)*dt; 
%   Ki(1,1) = 0;
   u = -Ki*[ x ; interr ];
   if( u > C0max)
       u = C0max;
   elseif(u < -C0max)
       u = -C0max;
   end
   C0i(k,1) = u;
   x = Ak*x + Bk*u;
   k = k+1;
end
figure(2);
subplot(3,1,1);   plot(t,C1i,t,C1);
subplot(3,1,2);   plot(t,C2i,t,C2);
subplot(3,1,3);   plot(t,C0i,t,C0);
