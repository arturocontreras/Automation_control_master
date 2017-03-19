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

A11=A(1,1); A12=A(1,2:3);
A21=A(2:3,1); A22=A(2:3,2:3);
B_1=B(1,1); B2=B(2:3,1);
Cr=A12;

q1=input('peso velocidad[0.1] =');
q2=input('peso corriente[0.1] =');
QQ=diag([q1 q2]);
R=1;
S=are(A22,A12'*inv(R)*A12,QQ);
Lx=S*A12'*inv(R);

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
Cx=[1 0 0];
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
   
A111=A1(1,1); A121=A1(1,2:3);
A211=A1(2:3,1); A221=A1(2:3,2:3);
B11=B1(1,1); B21=B1(2:3,1);
Cr1=A121;

q11=q1;%input('peso velocidad[0.1] =');
q21=q2;%input('peso corriente[0.1] =');
QQ=diag([q11 q21]);
R=1;
S=are(A221,A121'*inv(R)*A121,QQ);
Ly=S*A121'*inv(R);

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
 Cy=[1 0 0];
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

%motor y
q11 =0;% input('Peso q1 [0]   : ');
q21 =0;% input('Peso q2 [0]   : ');
q31 =0;% input('Peso q3 [0]   : ');
q41 =1e6;% input('Peso q4 [1e6 - 1e7] : ');
Q1 = diag([ q11 q21 q31 q41 ]);
RR1 = [ 1 ];
P1 = are(Ai1,Bi1*inv(RR1)*Bi1',Q1);
K1 = inv(RR1)*Bi'*P1; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = 0.05;%0.0005;

ti = 0;
tf = 80;
t = ti:dt:tf;
t = t';
nt =length(t);


ttp = ti:dt:tf;
ttp = ttp';
%
vel = input('ingresar velocidad [1] : ');
%valores conocido eje x
rx =  (ttp<0.05/vel).*(3*vel*ttp)+((ttp>=0.05/vel)&(ttp<0.15/vel)).*(-vel/2*(ttp-0.15/vel)+0.10)+((ttp>=0.15/vel)&(ttp<0.20/vel)).*(-vel*(ttp-0.20/vel)+0.05)...
    +((ttp>=0.20/vel)&(ttp<0.25/vel)).*(0.05)+((ttp>=0.25/vel)&(ttp<0.30/vel)).*(-vel*(ttp-0.30/vel)+0)...
    +((ttp>=0.30/vel)&(ttp<0.40/vel)).*(vel/2*(ttp-0.40/vel)+0.05)+((ttp>=0.40/vel)&(ttp<0.45/vel)).*(-vel*(ttp-0.45/vel)+0);
Awx=A22-Lx*A12;
Bwx=B2-Lx*B_1;
Lwx=A21-Lx*A11+A22*Lx-Lx*A12*Lx;
%valores conocido eje y
ry =  (ttp<0.05/vel).*(vel*ttp)+((ttp>=0.05/vel)&(ttp<0.15/vel)).*(vel*(ttp-0.15/vel)+0.15)+((ttp>=0.15/vel)&(ttp<(0.20)/vel)).*(0.15)...
    +((ttp>=0.20/vel)&(ttp<0.25/vel)).*(-vel*(ttp-0.25/vel)+0.10)+((ttp>=0.25/vel)&(ttp<0.30/vel)).*(vel*(ttp-0.30/vel)+0.15)...
    +((ttp>=0.30/vel)&(ttp<0.40/vel)).*(-vel*(ttp-0.40/vel)+0.05)+((ttp>=0.40/vel)&(ttp<0.45/vel)).*(-vel*(ttp-0.45/vel)+0);

Awy=A221-Ly*A121;
Bwy=B21-Ly*B11;
Lwy=A211-Ly*A111+A221*Ly-Ly*A121*Ly;

[Akox,Bkox] = c2d(Awx,Bwx,dt);
[Akox,Lkox] = c2d(Awx,Lwx,dt);
[Akoy,Bkoy] = c2d(Awy,Bwy,dt);
[Akoy,Lkoy] = c2d(Awy,Lwy,dt);



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
wx=[0;0];
interr1 = 0;
J1 = 0;
wy=[0;0];
e1=0;
e2=0;
rxs=0;
rys=0;
%
for tt = ti:dt:tf
     yx=Cx*[x(1,1)+0*0.001*randn(1,1);x(2,1);x(3,1)];
     yy=Cy*[x1(1,1)+0*0.001*randn(1,1);x1(2,1);x1(3,1)];
   poss(kc,1) = x(1,1);
   vel(kc,1) = x(2,1);
   amp(kc,1) = x(3,1);
   
   poss1(kc,1) = x1(1,1);
   vel1(kc,1) = x1(2,1);
   amp1(kc,1) = x1(3,1);
   time(kc,1) = tt;
   xhx=wx+Lx*yx;
   xhy=wy+Ly*yy;
         vel_obsx(kc,1)=xhx(1,1);
        amp_obsx(kc,1)=xhx(2,1);
         vel_obsy(kc,1)=xhy(1,1);
         amp_obsy(kc,1)=xhy(2,1);
   
   interr = interr + (x(1,1)-rx(kc,1))*dt;
   interr1 = interr1 + (x1(1,1)-ry(kc,1))*dt;
   ufb = -K*[ [x(1,1);xhx(1,1);xhx(2,1)]'  interr ]';
   ufb1 = -K1*[ [x1(1,1);xhy(1,1);xhy(2,1)]'  interr1 ]';
 
   u = ufb;
   u1 = ufb1;
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
   wx=Akox*wx+Bkox*u+Lkox*(yx);
   wy=Akoy*wy+Bkoy*u1+Lkoy*(yy);
   kc = kc + 1;
end
desemp=sqrt(et/rt)*100
max_error_x=max(e11)
max_error_y=max(e22)
%J = J/1e3;
rx = rx(1:nt,1);
ry = ry(1:nt,1);
maxu = max(volt);
disp(['Maximo voltaje : ',num2str(maxu)]);
%disp(['Valor de J = ',num2str(J),'*10^3']);
figure(1)
plot(rx,ry,poss,poss1);grid;
legend('referencia','preview');
figure(2)
subplot(3,1,1);plot(time,poss,time,rx);   grid;   title('motor x'); 
legend('pos medido','pos rx');
subplot(3,1,2);plot(time,vel,time,vel_obsx);grid;
legend('vel medido','vel observado');
subplot(3,1,3);plot(time,amp,time,amp_obsx);grid;
legend('amp medido','amp observado');
figure(3)
subplot(3,1,1);plot(time,poss1,time,ry);   grid;   title('motor y'); 
legend('pos medido','pos ry');
subplot(3,1,2);plot(time,vel1,time,vel_obsy);grid;
legend('vel medido','vel observado');
subplot(3,1,3);plot(time,amp1,time,amp_obsy);grid;
legend('amp medido','amp observado');