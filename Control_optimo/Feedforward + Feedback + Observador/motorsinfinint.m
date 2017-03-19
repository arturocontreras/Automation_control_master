clear;
close all;
clc;

%  Meta llegar a r = 0.3m en menos de 2 seg.

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;

I = 0.5*4.326e-5;
p = 0.005;
m = 0.5*1.00;
c = 0.01*40;
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
    
Ai = [ 0   1   0   0 
       0  a22 a23  0
       0  a32 a33  0
       1   0   0   0 ]; 
    
Bi = [ 0
       0
       b31
       0 ]; 
    
Wri = [ 0
        0       
        0
       -1 ];
    
Wfi = [ 0
        w21      
        0
        0 ];   
        
q1 = input('Peso q1 [1.2e5] : ');
q2 = input('Peso q2 [0]        : ');
q3 = input('Peso q3 [0]        : ');
q4 = input('Peso q4 [1e6]    : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];

P = are(Ai,Bi*inv(RR)*Bi',Q);
K = inv(RR)*Bi'*P; 

%  Observador
q1 = input('Peso Obs q1 [1] : ');
q2 = input('Peso Obs q2 [1] : ');
q3 = input('Peso Obs q3 [1] : ');
Q = diag([ q1 q2 q3 ]);
C = [ 1 0 0 ];
S = are(A',C'*C,Q);
L = S*C';
dt = 0.002;
[Ak,Bk] = c2d(A,B,dt);
[Ak,Wk] = c2d(A,Wf,dt);
[Aok,Bok] = c2d(A-L*C,B,dt);
[Aok,Lok] = c2d(A-L*C,L,dt); 
ti = 0;
tf = 10;
t = ti:dt:tf;
t = t';
nt = length(t);

%rmax = input('Posicion deseada : ');
rmax = 0.3;
r = rmax*ones(nt,1);
%r(1:nr1,1) = r1;

Fseca = 0.0*2;   %  Friccion. Coeficiente de 0 a 1 
vmax = 24;

x(1,1) = 0.0;
x(2,1) = 0;
x(3,1) = 0;
xo(1,1) = 0;
xo(2,1) = 0;
xo(3,1) = 0;

k = 1;
interx = 0;
for tt = ti:dt:tf
   y = C*x + 0.01*randn(1,1);
   sensor(k,1) = y;
   pos(k,1) = x(1,1);
   vel(k,1) = x(2,1);
   amp(k,1) = x(3,1);
   poso(k,1) = xo(1,1);
   er = xo(1,1) - r(k,1);
   interx = interx + er*dt;
  u = -K*[ xo(1,1)
              xo(2,1)
             xo(3,1)
             interx ];
   if( u > vmax)
      u = vmax;            
   elseif( u < -vmax )
      u = -vmax;
   end      
   volt(k,1) = u;
   pot(k,1) = u*x(3,1);
   if(x(2,1) >= 0)
      Ff = Fseca;
   elseif(x(2,1) < 0)
      Ff = -Fseca;
   end   
   x = Ak*x + Bk*u + Wk*Ff;
   xo = Aok*xo + Bok*u + Lok*y;
   k = k+1;   
end

figure(1);
plot(t,pos,'-r',t,r,'-g',t,poso,'-b',t,sensor,'-y');
title('Posición m');
figure(2);
plot(t,vel);
title('Velocidad m/s');
figure(3);
plot(t,amp);
title('Corriente A');
figure(4);
plot(t,volt);
title('Voltaje v');
figure(5);
plot(t,pot);
title('Potencia W');

K13 = K(1,1:3);
K4 = K(1,4);
cero13 = zeros(1,3);
cero31 = zeros(3,1);
CC = [ 1 0 0 ];
Acl = [ A    -B*K13       -B*K4
        L*C  A-B*K13-L*C  -B*K4
        cero13  CC          0   ];
Bcl = [ cero31
        cero31
        -1 ];
Ccl = [ 1 0 0 0 0 0 0 ];
Dcl = [ 0 ];
ystep = step(Acl,Bcl,Ccl,Dcl,1,t);
figure(6);
plot(t,ystep);

fre = 0:0.05:10;
fre = fre';
wrs = 2*pi*fre;
[mag fase] = bode(Acl,Bcl,Ccl,Dcl,1,wrs);
figure(7);
subplot(2,1,1); loglog(fre,mag);
subplot(2,1,2); semilogx(fre,fase);

