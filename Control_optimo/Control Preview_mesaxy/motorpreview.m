% Control Preview - Tiempo Continuo
% Motor con Tornillo Sinfin
% Pesos:   q1 = q2 = q3 = 0      q4 = 1e7
% Frecuencia de la referencia r:   0.2 Hz
% Probar con tiempo de preview tp:  0, 0.2, 0.4, 0.6, 0.7, 0.8, 1.0.

clear;
close all;
clc;

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.004;
m = 1.00;
c = 40;
r = 0.015;
alfa = 45*pi/180;
voltmax = 30;
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
        
q1 = input('Peso q1 [0]   : ');
q2 = input('Peso q2 [0]   : ');
q3 = input('Peso q3 [0]   : ');
q4 = input('Peso q4 [1e6 - 1e7] : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];
P = are(Ai,Bi*inv(RR)*Bi',Q);
K = inv(RR)*Bi'*P; 
Ac = Ai - Bi*K;

tp = input('Introducir tiempo preview : ');
dt = 0.0005;
np = round(tp/dt);
qq = P*Wri*dt;
for n = 1:np
   qq = [ qq  expm(Ac'*n*dt)*P*Wri*dt ];
end
Kpr = inv(RR)*Bi';

ti = 0;
tf = 10;
t = ti:dt:tf;
t = t';
nt =length(t);

fre = input('Frecuencia en Hz [0.25] : ');
ttp = ti:dt:(tf + tp);
ttp = ttp';
r = 0.15*sin(2*pi*fre*ttp);

[Ak,Bk] = c2d(A,B,dt);
x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;
kc = 1;
interr = 0;
J = 0;

for tt = ti:dt:tf
   pos(kc,1) = x(1,1);
   vel(kc,1) = x(2,1);
   amp(kc,1) = x(3,1);
   time(kc,1) = tt;
   interr = interr + (x(1,1)-r(kc,1))*dt;
   ufb = -K*[ x'  interr ]';
   k1 = kc;
   k2 = k1 + np;
   rq = r(k1:k2,1);
   upr = -Kpr*qq*rq;
   [ufb upr];
   u = ufb + upr;
   if( u > voltmax )
      u = voltmax;
   elseif( u < -voltmax )
      u = -voltmax;
   end
   J = J + 1/2*([ x'  interr]*Q*[x' interr]' + u'*RR*u)*dt; 
   volt(kc,1) = u;
   x = Ak*x + Bk*u;
   kc = kc + 1;
end
J = J/1e3;
r = r(1:nt,1);
maxu = max(volt);
disp(['Maximo voltaje : ',num2str(maxu)]);
disp(['Valor de J = ',num2str(J),'*10^3']);
figure(1);   plot(time,pos,time,r);   grid;   title('Posicion');  
figure(2);   plot(time,volt);         grid;   title('Voltaje');




