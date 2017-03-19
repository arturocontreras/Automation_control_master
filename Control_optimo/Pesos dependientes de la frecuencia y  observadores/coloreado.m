% Control LQR del sistema de suspensión de un automóvil
clear;
close all;
clc;

m2 = 10;
m1 = 1;
k2 = 2*pi*1*m2;
c2 = 5;
k1 = 2*pi*8*m1;

a11 = -c2/m2;
a12 = -k2/m2;
a13 =  c2/m2;
a31 =  c2/m1;
a32 =  k2/m1;
a33 = -c2/m1;
a34 = -k1/m1;

b1 =  1/m2;
b3 = -1/m1;
% matriz de resorte 
A = [ a11  a12  a13   0
       1    0   -1    0
      a31  a32  a33  a34
       0    0    1    0 ];

B = [ b1
      0
      b3 
      0 ];
BB = [ B
       0];
  
W = [ 0
      0
      0
     -1 ];
 %%%matriz aumentada con ruido coloreado
 AA = [   A       -0.5*W
        zeros(1,4) -0.5   ];
    
%q1 = input('Peso x2p   : ');
qx2p=input('Peso x2p : ');
q2 = input('Peso x2-x1 : ');  
%q3 = input('Peso x1p   : ');
q4 = input('Peso x1-x0 : ');
Q = [  0  0  0  0  0 
       0 q2  0  0  0
       0  0  0  0  0
       0  0  0 q4  0
       0  0  0  0  0 ];
   S=[qx2p 0 0 0 0
       0   0 0 0 0
       0   0 0 0 0
       0   0 0 0 0
       0   0 0 0 0 ];
   
R = [ 1 ];
QQ=Q'+AA'*S*AA;
N=AA'*S*BB;
  
RR=R+BB'*S*BB;
P = are(AA-BB*inv(RR)*N',BB*inv(RR)*BB',QQ-N*inv(RR)*N');
K = inv(RR)*BB'*P;

dt = 0.001;
ti = 0;
tf = 10;
t = ti:dt:tf;   t = t';
nt = length(t);
[Ak,Bk] = c2d(A,B,dt);
[Ak,Wk] = c2d(A,W,dt);

ruid=0.5*rand(nt,1);
xop = 0;

x = [ 0;  0;  0;  0 ];
x2pp=0;
k = 1;
for tt = ti:dt:tf
  x2vc(k,1) = x(1,1);
  x21c(k,1) = x(2,1);
  x1vc(k,1) = x(3,1);
  x10c(k,1) = x(4,1);
  x2_pp(k,1)=x2pp;
  ruid_color(k,1)=xop;
  
  u = -K(1:4)*x - K(5)*xop;
  Fc(k,1) = u;
  xop=-0.5*xop + ruid(k,1)/2;
  x2pp=A(1,:)*x+B(1,1)*u+W(1,1)*xop;
  x = Ak*x + Bk*u + Wk*xop;
  t(k,1) = tt;
  k = k + 1;
end

figure(1);
subplot(2,2,1);  plot(t,ruid);  grid;
ylabel('ruido');
    subplot(2,2,2);   plot(t,Fc,'-r');grid
    ylabel('F');

subplot(2,2,3);  plot(t,x21c,'-r');   grid;
ylabel('x21');
subplot(2,2,4);  plot(t,x10c);   grid;
ylabel('x10');
xlabel('Tiempo [seg]');
figure(2)
subplot(2,1,1); plot(t,ruid_color,'-r');grid
ylabel('ruido coloreado');
subplot(2,1,2); plot(t,x2_pp,'-r');grid
ylabel('x2p');
       

       
       


