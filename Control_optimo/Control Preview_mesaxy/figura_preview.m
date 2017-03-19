clear;
close all;
clc;
% motor eje x
R = 1.8;
L = 0.000159;
Kt = 0.05871;
Kb = 0.05567;
I = 4.534e-5;
p = 0.0028;
m = 0.13;
c = 95;
r = 0.011;
alfa = 60*pi/180;
voltmax = 40;
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor eje y
R1 = 1.92;
L1 = 0.0001801;
Kt1 = 0.08925;
Kb1 = 0.09156;
I1 = 9.8342e-5;
p1 = 0.0042;
m1 = 0.375+0.218+0.13;
c1 = 95;
r1 = 0.02;
alfa1 = 60*pi/180;
voltmax1 = 50;
d1 = m1 + 2*pi*I1*tan(alfa1)/(p1*r1);

a22 = -c1/d1;
a23 = Kt1*tan(alfa1)/(r1*d1);
a32 = -2*pi*Kb1/(p1*L1);
a33 = -R1/L1;
b31 = 1/L1;
w21 = -1/d1;
A1 = [ 0   1   0  
      0  a22 a23 
      0  a32 a33 ];
B1 = [ 0
      0
      b31 ];
Wf1 = [ 0
       w21       
       0 ];
    
Ai1 = [ 0   1   0   0 
       0  a22 a23  0
       0  a32 a33  0
       1   0   0   0 ]; 
Bi1 = [ 0
       0
       b31
       0 ]; 
Wri1 = [ 0
        0       
        0
       -1 ];
Wfi1 = [ 0
        w21      
        0
        0 ];   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%motor x
q1 =0;% input('Peso q1 [0]   : ');
q2 =0;% input('Peso q2 [0]   : ');
q3 =0;% input('Peso q3 [0]   : ');
q4 =1e6;% input('Peso q4 [1e6 - 1e7] : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];
P = are(Ai,Bi*inv(RR)*Bi',Q);
K = inv(RR)*Bi'*P; 
Ac = Ai - Bi*K;
%motor y
q11 =0;% input('Peso q1 [0]   : ');
q21 =0;% input('Peso q2 [0]   : ');
q31 =0;% input('Peso q3 [0]   : ');
q41 =1e10;% input('Peso q4 [1e6 - 1e7] : ');
Q1 = diag([ q11 q21 q31 q41 ]);
RR1 = [ 1 ];
P1 = are(Ai1,Bi1*inv(RR1)*Bi1',Q1);
K1 = inv(RR1)*Bi'*P1; 
Ac1 = Ai1 - Bi1*K1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculo de q para motor x
tp = input('Introducir tiempo preview  x : ');
    tpy = input('Introducir tiempo preview y  : ');
dt = 0.05;%0.0005;
np = round(tp/dt);
    npy = round(tpy/dt);
qq = P*Wri*dt;
for n = 1:np
   qq = [ qq  expm(Ac'*n*dt)*P*Wri*dt ];
end
Kpr = inv(RR)*Bi';
%calculo de q para motor y
qq1 = P*Wri1*dt;
for n = 1:npy
   qq1 = [ qq1  expm(Ac'*n*dt)*P*Wri1*dt ];
end
Kpr1 = inv(RR)*Bi1';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ti = 0;
tf = 120;
t = ti:dt:tf;
t = t';
nt =length(t);


ttp = ti:dt:(tf + tp);
ttp = ttp';

ttpy = ti:dt:(tf + tpy);
ttpy = ttpy';


vel = input('ingresar velocidad [1] : ');
%valores conocido eje x
rx =  (ttp<0.05/vel).*(3*vel*ttp)+((ttp>=0.05/vel)&(ttp<0.15/vel)).*(-vel/2*(ttp-0.15/vel)+0.10)+((ttp>=0.15/vel)&(ttp<0.20/vel)).*(-vel*(ttp-0.20/vel)+0.05)...
    +((ttp>=0.20/vel)&(ttp<0.25/vel)).*(0.05)+((ttp>=0.25/vel)&(ttp<0.30/vel)).*(-vel*(ttp-0.30/vel)+0)...
    +((ttp>=0.30/vel)&(ttp<0.40/vel)).*(vel/2*(ttp-0.40/vel)+0.05)+((ttp>=0.40/vel)&(ttp<0.45/vel)).*(-vel*(ttp-0.45/vel)+0);
%valores conocido eje y
ry =  (ttpy<0.05/vel).*(vel*ttpy)+((ttpy>=0.05/vel)&(ttpy<0.15/vel)).*(vel*(ttpy-0.15/vel)+0.15)+((ttpy>=0.15/vel)&(ttpy<(0.20)/vel)).*(0.15)...
    +((ttpy>=0.20/vel)&(ttpy<0.25/vel)).*(-vel*(ttpy-0.25/vel)+0.10)+((ttpy>=0.25/vel)&(ttpy<0.30/vel)).*(vel*(ttpy-0.30/vel)+0.15)...
    +((ttpy>=0.30/vel)&(ttpy<0.40/vel)).*(-vel*(ttpy-0.40/vel)+0.05)+((ttpy>=0.40/vel)&(ttpy<0.45/vel)).*(-vel*(ttpy-0.45/vel)+0);

[Ak,Bk] = c2d(A,B,dt);
[Ak1,Bk1] = c2d(A1,B1,dt);
x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;

x1(1,1) = 0;
x1(2,1) = 0;
x1(3,1) = 0;
kc = 1;
interr = 0;
J = 0;
interr1 = 0;
J1 = 0;
e1=0;
e2=0;
rxs=0;
rys=0;
for tt = ti:dt:tf
   poss(kc,1) = x(1,1);
   vel(kc,1) = x(2,1);
   amp(kc,1) = x(3,1);
   
   poss1(kc,1) = x1(1,1);
   vel1(kc,1) = x1(2,1);
   amp1(kc,1) = x1(3,1);
   time(kc,1) = tt;
   interr = interr + (x(1,1)-rx(kc,1))*dt;
   interr1 = interr1 + (x1(1,1)-ry(kc,1))*dt;
   ufb = -K*[ x'  interr ]';
   ufb1 = -K1*[ x1'  interr1 ]';
   k1 = kc;
   k2 = k1 + np;
   k2y = k1 + npy;
   rq = rx(k1:k2,1);
   rq1 = ry(k1:k2y,1);
   upr = -Kpr*qq*rq;
   upr1 = -Kpr1*qq1*rq1;
   [ufb upr];
   u = ufb + upr;
   u1 = ufb1 + upr1;
   if( u > voltmax )
      u = voltmax;
   elseif( u < -voltmax )
      u = -voltmax;
   end
     if( u1 > voltmax1 )
      u1 = voltmax1;
   elseif( u1 < -voltmax1 )
      u1 = -voltmax1;
   end
   %J = J + 1/2*([ x'  interr]*Q*[x' interr]' + u'*RR*u)*dt; 
   e1=e1+(rx(kc,1)-x(1,1))^2;
   e11(kc,1)=e1;
   e2=e2+(ry(kc,1)-x1(1,1))^2;
   e22(kc,1)=e2;
   et=e1+e2;
   rxs=rxs+rx(kc,1)^2;
   rys=rys+ry(kc,1)^2;
   rt=rxs+rys;
   
   
   volt(kc,1) = u;
   volt1(kc,1) = u1;
   x = Ak*x + Bk*u;
   x1 = Ak1*x1 + Bk1*u1;
   kc = kc + 1;
end
desemp=sqrt(et/rt)*100
max_error_x=max(e11)
max_error_y=max(e22)
%J = J/1e3;
rx = rx(1:nt,1);
ry = ry(1:nt,1);
maxu_x = max(volt);
maxu_y = max(volt1);
disp(['Maximo voltaje : ',num2str(maxu_x)]);
%disp(['Valor de J = ',num2str(J),'*10^3']);
figure(1);   plot(time,poss,time,rx);   grid;   title('Posicion'); 
legend('posicion estado','tracking')
figure(2);   plot(time,poss1,time,ry);   grid;   title('Posicion'); 
figure (3); plot(rx,ry,poss,poss1);grid;
legend('referencia','preview');




