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
   Cx=[1 0 0];
q1=input('peso posicion[1] =');
q2=input('peso velocidad[1] =');
q3=input('peso corriente[1] =');

QQ=diag([q1 q2 q3]);
R=eye(3,3);
S=are(A,inv(R),QQ);
Lx=inv(R)*S*Cx'*inv(Cx*Cx');

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
    Cy=[1 0 0];
q11=q1;%input('peso posicion[0.1] =');
q21=q2;%input('peso velocidad[0.1] =');
q31=q3;%input('peso corriente[0.1] =');
QQ=diag([q11 q21 q31]);
R=eye(3,3);
S=are(A,inv(R),QQ);
Ly=inv(R)*S*Cy'*inv(Cy*Cy');

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

%valores conocido eje y
ry =  (ttp<0.05/vel).*(vel*ttp)+((ttp>=0.05/vel)&(ttp<0.15/vel)).*(vel*(ttp-0.15/vel)+0.15)+((ttp>=0.15/vel)&(ttp<(0.20)/vel)).*(0.15)...
    +((ttp>=0.20/vel)&(ttp<0.25/vel)).*(-vel*(ttp-0.25/vel)+0.10)+((ttp>=0.25/vel)&(ttp<0.30/vel)).*(vel*(ttp-0.30/vel)+0.15)...
    +((ttp>=0.30/vel)&(ttp<0.40/vel)).*(-vel*(ttp-0.40/vel)+0.05)+((ttp>=0.40/vel)&(ttp<0.45/vel)).*(-vel*(ttp-0.45/vel)+0);



[Akox,Bkox] = c2d(A-Lx*Cx,B,dt);
[Akox,Lkox] = c2d(A-Lx*Cx,Lx,dt);
[Akoy,Bkoy] = c2d(A1-Ly*Cy,B1,dt);
[Akoy,Lkoy] = c2d(A1-Ly*Cy,Ly,dt);



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
xhx=[0;0;0];
interr1 = 0;
J1 = 0;
xhy=[0;0;0];
e1=0;
e2=0;
rxs=0;
rys=0;
%
for tt = ti:dt:tf
     yx=Cx*[x(1,1)+0*0.1*randn(1,1);x(2,1);x(3,1)];
     yy=Cy*[x1(1,1)+0*0.1*randn(1,1);x1(2,1);x1(3,1)];
   poss(kc,1) = x(1,1);
   vel(kc,1) = x(2,1);
   amp(kc,1) = x(3,1);
   
   poss1(kc,1) = x1(1,1);
   vel1(kc,1) = x1(2,1);
   amp1(kc,1) = x1(3,1);
   time(kc,1) = tt;
  
         pos_obsx(kc,1)=xhx(1,1);
         vel_obsx(kc,1)=xhx(2,1);
        amp_obsx(kc,1)=xhx(3,1);
         pos_obsy(kc,1)=xhy(1,1);
         vel_obsy(kc,1)=xhy(2,1);
         amp_obsy(kc,1)=xhy(3,1);
   
   interr = interr + (xhx(1,1)-rx(kc,1))*dt;
   interr1 = interr1 + (xhy(1,1)-ry(kc,1))*dt;
   ufb = -K*[ xhx'  interr ]';
   ufb1 = -K1*[ xhy'  interr1 ]';
 
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
        e1=e1+(rx(kc,1)-x(1,1))^2;
   e11(kc,1)=e1;
   e2=e2+(ry(kc,1)-x1(1,1))^2;
   e22(kc,1)=e2;
   et=e1+e2;
   rxs=rxs+rx(kc,1)^2;
   rys=rys+ry(kc,1)^2;
   rt=rxs+rys;
   
   %J = J + 1/2*([ x'  interr]*Q*[x' interr]' + u'*RR*u)*dt; 
   volt(kc,1) = u;
   volt1(kc,1) = u1;
   x = Ak*x + Bk*u;
   x1 = Ak1*x1 + Bk1*u1;
   xhx=Akox*xhx+Bkox*u+Lkox*(yx);
   xhy=Akoy*xhy+Bkoy*u1+Lkoy*(yy);
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
subplot(3,1,1);plot(time,poss,'-b',time,pos_obsx,'--r');   grid;   title('motor x'); 
legend('pos medido','pos rx');
subplot(3,1,2);plot(time,vel,'-b',time,vel_obsx,'--r');grid;
legend('vel medido','vel observado');
subplot(3,1,3);plot(time,amp,'-b',time,amp_obsx,'--r');grid;
legend('amp medido','amp observado');
figure(3)
subplot(3,1,1);plot(time,poss1,'-b',time,pos_obsy,'--r');   grid;   title('motor y'); 
legend('pos medido','pos ry');
subplot(3,1,2);plot(time,vel1,'-b',time,vel_obsy,'--r');grid;
legend('vel medido','vel observado');
subplot(3,1,3);plot(time,amp1,'-b',time,amp_obsy,'--r');grid;
legend('amp medido','amp observado');