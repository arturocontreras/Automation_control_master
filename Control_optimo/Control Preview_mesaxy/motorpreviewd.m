% Control preview en tiempo discreto.
% Motor con tornillo sinfin
% Pesos:  q1 = q2 = q3 = 0     q4 = 1e6
% Frecuencia de referencia r:  0.2 Hz
% Probar tiempo de preview tp = 0, 0.2, 0.4, 0.6, 0.7, 0.8

clear;
close all;
clc;

R = 1.1;
L = 0.00005;
Kt = 0.0573;
Kb = 0.05665;
I = 2.326e-5;
p = 0.0075;
m = 1.00;
c = 40;
r = 0.02;
alfa = 75*pi/180;
voltmax = 24;
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
     
dt = 0.001;
[Aik,Bik]  = c2d(Ai,Bi,dt);
[Aik,Wrik] = c2d(Ai,Wri,dt);
     
q1 = input('Peso q1 [0]   : ');
q2 = input('Peso q2 [0]   : ');
q3 = input('Peso q3 [0]   : ');
q4 = input('Peso q4 [1e6] : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];

P = dare(Aik,Bik,Q);
Kx = inv(RR + Bik'*P*Bik)*Bik'*P*Aik; 
Ac = Aik - Bik*Kx;
V = inv(RR + Bik'*P*Bik)*Bik';

ti = 0;
tf = 10;
t = ti:dt:tf;
t = t';
nt = length(t);

for cc = 1:3

tp = input('Introducir tiempo preview seg [0, 0.25, 0.50]: ');
np = round(tp/dt);

AcT = Ac';
qq = P*Wrik;
for n = 1:np
   qq = [ qq  (AcT^n)*P*Wrik ];
end
Kz = V*qq;


fre = input('Introducir frecuencia Hz [0.25 Hz] : ');
ttp = ti:dt:(tf+tp);
ttp = ttp';
r = 0.15*sin(2*pi*fre*ttp);
% r = 0.15*ones(nt,1);
% ntp = round(nt/8);
% r(1:ntp,1) = zeros(ntp,1);


x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;
x(4,1) = 0;

k = 1;
J = 0;
%for tt = ti:dt:(tf-tp)
for tt = ti:dt:tf    
   pos(k,1) = x(1,1);
   vel(k,1) = x(2,1);
   amp(k,1) = x(3,1);
   tim(k,1) = tt;
   k1 = k;
   k2 = k + np;
   rq = r(k1:k2,1);
   ufb = -Kx*x;
   upr = -Kz*rq;
   u = ufb + upr;  
   if( u > voltmax )
      u = voltmax;
   elseif( u < -voltmax )   
      u = -voltmax;
   end
   volt(k,1) = u;
   J = J + 1/2*(x'*Q*x + u'*RR*u);
   x = Aik*x + Bik*u + Wrik*r(k,1);
   k = k+1;   
end
disp(' ');
disp(['Tiempo de Preview: ',num2str(tp)]);
disp(['El valor de J es: ',num2str(J)]);
disp(['El valor máximo del voltaje es: ',num2str(max(volt))]);
disp(' ');
r = r(1:k-1,1);
figure(1);
plot(tim,pos,t,r);
title('Posición m');
axis([ ti tf -0.2  0.2]);
hold on;
figure(2);
plot(tim,volt);
title('Voltaje v');
hold on;
end










