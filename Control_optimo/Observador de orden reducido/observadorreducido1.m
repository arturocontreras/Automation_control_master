% Observador de orden reducido para motor con tornillo sinfin.
% Se mide la posicion x. La velocidad xp y la corriente i se
% estiman con un observador de orden 2.
% El observador se ha adaptado de manera que no se calculen 
% derivadas

clear;
clc;
close all;

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.003;
m = 1.00;
c = 40;  %Fricci�n viscosa aparece dentro del modelo
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
      0  a32 a33 ];  %Matriz A
      
B = [ 0
      0
      b31 ];      %Matriz B
   
Wf = [ 0
       w21       
       0 ];      %Fricci�n seca act�a como una perturbaci�n no lineal
      
C = [ 1  0  0 ];   

A11 = A(1,1);     A12 = A(1,2:3);
A21 = A(2:3,1);   A22 = A(2:3,2:3);
B1 = B(1,1);
B2 = B(2:3,1);
Cr = A12;

q2 = input('Peso q2 (xp) : ');
q3 = input('Peso q3 (i)  : ');
Q = diag([ q2 q3 ]);
S = are(A22',Cr'*Cr,Q);
L = S*Cr';
ti = 0;    tf = 2;    dt = 0.001;
t = ti:dt:tf;    t = t';
nt = length(t);

Aw = A22 - L*A12;
Bw = B2 - L*B1;
Lw = A21 - L*A11 + A22*L - L*A12*L;


[Ak,Bk] = c2d(A,B,dt);  %Se discretiza
[Ak,Wk] = c2d(A,Wf,dt);
[Ahk,Bhk] = c2d(Aw,Bw,dt);
[Ahk,Lhk] = c2d(Aw,Lw,dt);

fre = 1;
u = 10*sin(2*pi*fre*t);
ruido = 1*0.02*randn(nt,1);

x  = [ 0.15
       -0.12
        0.3 ];

wh = [ 0
          0 ];
   
k = 1;
umax = 24;
Fseca = 0.5*2;   %Se empieza con cero y se cambia para considerar Ff
for tt = ti:dt:tf
  y(k,1) = x(1,1) + 1*ruido(k,1);
  x1(k,1)  = x(1,1);    x2(k,1)  = x(2,1);    x3(k,1)  = x(3,1);
  xh = wh + L*y(k,1);
  x2h(k,1) = xh(1,1);
  x3h(k,1) = xh(2,1);
  if( u(k,1) > umax )
      u(k,1) = umax;
  elseif ( u(k,1) < -umax ) 
      u(k,1) = -umax;
  end
  if(x(2,1) >= 0)
     Ff = Fseca;
  elseif(x(2,1) < 0)
     Ff = -Fseca;
  end     
  x = Ak*x + Bk*u(k,1) + Wk*Ff;    %Planta
  wh = Ahk*wh + Bhk*u(k,1) + Lhk*y(k,1);   %Observador
  k = k + 1;   
end
 
figure(1);   plot(t,y,'-g',t,x1,'--r');   title('Posici�n');
figure(2);   plot(t,x2,'-r',t,x2h,'-b'); title('Velocidad');
figure(3);   plot(t,x3,'-r',t,x3h,'-b'); title('Corriente');
figure(4);   plot(t,u);                     title('Voltaje');





   
