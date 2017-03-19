% Diseño de observador optimal para sistema lineal
% La ecuación de Riccati es distinta a la del Filttro de Kalman

clear;
close all;
clc;

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.003;
m = 1.00;
c = 40;
r = 0.015;
alfa = 45*pi/180;
d = m + 2*pi*I*tan(alfa)/(p*r);
a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;
A = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
B = [ 0
      0
      b31 ];
Wf = [ 0
       w21       
       0 ];
C = [ 1   0    0 ];
Obs = [ C;   C*A;   C*A*A ];
detObs = det(Obs)

q1o = input('Peso q1o : ');
q2o = input('Peso q2o : ');
q3o = input('Peso q3o : ');
Qo = diag([ q1o q2o q3o ]);
Ro = eye(3);
So = are(A,inv(Ro),Qo);
L = inv(Ro)*So*C'*inv(C*C'); 

ti = 0;    tf = 4;      dt = 0.001;
t = ti:dt:tf;    t = t';
nt = length(t);
[Ak,Bk]  = c2d(A,B,dt);
[Ak,Wk] = c2d(A,Wf,dt);
[Aok Bok] = c2d(A-L*C,B,dt);
[Aok Lok] = c2d(A-L*C,L,dt); 
vmax = 24;
fre = 1;
u = vmax*sin(2*pi*fre*t);
Fseca = 0.5*8;
x   = [ -0.2;  -0.3;  0.8 ];
xo = [ 0;  0;   0 ];
k = 1;
for tt = ti:dt:tf
   y = C*x + 0.01*randn(1,1);
   yy(k,1) = y;
   xx1(k,1) = x(1,1);       xx2(k,1) = x(2,1);      xx3(k,1) = x(3,1);
   xxo1(k,1) = xo(1,1);   xxo2(k,1) = xo(2,1);   xxo3(k,1) = xo(3,1); 
   if(x(2,1) >= 0)
      Ff = Fseca;
   elseif(x(2,1) < 0)
      Ff = -Fseca;
   end   
   x   = Ak*x + Bk*u(k,1) + Wk*Ff;
   xo = Aok*xo + Bok*u(k,1) + Lok*y; 
   k = k+1;   
end

figure(1);
plot(t,xx1,'-r',t,xxo1,'-b',t,yy,'-g');     grid;      title('Posición m');
figure(2);
plot(t,xx2,'-r',t,xxo2,'-b');     grid;      title('Velocidad');
figure(3);
plot(t,xx3,'-r',t,xxo3,'-b');     grid;      title('Corriente');
