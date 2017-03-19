% Control LQR del sistema de suspensi�n de un autom�vil
% Dos grados de libertad
% Vector de estado: [ x2v  x2-x1  x1v  x1-x0 ]
% Entrada xop.

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

A = [ a11  a12  a13   0
       1    0   -1    0
      a31  a32  a33  a34
       0    0    1    0 ];
   
B = [ b1
      0
      b3 
      0 ];

W = [ 0
      0
      0
     -1 ];
    
q1 = input('Peso x2p   : ');
q2 = input('Peso x2-x1 : ');  
q3 = input('Peso x1p   : ');
q4 = input('Peso x1-x0 : ');

Q = [ q1  0  0  0
       0 q2  0  0
       0  0 q3  0
       0  0  0 q4 ];
R = [ 1 ];
P = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*P;

dt = 0.001;
ti = 0;
tf = 5;
t = ti:dt:tf;   t = t';
nt = length(t);
[Ak,Bk] = c2d(A,B,dt);
[Ak,Wk] = c2d(A,W,dt);

xop = zeros(nt,1); % Impulso
xop(1,1) = 0.1/dt;

x = [ 0;  0;  0;  0 ];

k = 1;
for tt = ti:dt:tf
  x2vc(k,1) = x(1,1);
  x21c(k,1) = x(2,1);
  x1vc(k,1) = x(3,1);
  x10c(k,1) = x(4,1);
  u = -K*x;
  potc(k,1) = u*(x2vc(k,1)-x1vc(k,1));

  Fc(k,1) = u;
  x = Ak*x + Bk*u + Wk*xop(k,1);
  t(k,1) = tt;
  k = k + 1;
end

%-------------con adicion de la potencia en la funcion de costo--------
x = [ 0;  0;  0;  0 ];

k = 1;
% X = [ x2v  x2-x1  x1v  x1-x0 ]
%P = are(A,B*inv(R)*B',Q); %sin potencia
n = input('ingresa n =  ');
N= [n 0 -n 0]';
P = are(A-B*inv(R)*N',B*inv(R)*B',Q-N*inv(R)*N');%considerando J = int (X'QX+2X'Nu+u'Ru)
K = inv(R)*(B'*P+N');

for tt = ti:dt:tf
  x2vn(k,1) = x(1,1);
  x21n(k,1) = x(2,1);
  x1vn(k,1) = x(3,1);
  x10n(k,1) = x(4,1);
  potn(k,1) = u*(x2vn(k,1)-x1vn(k,1));
  u = -K*x;
  Fn(k,1) = u;
  x = Ak*x + Bk*u + Wk*xop(k,1);
  t(k,1) = tt;
  k = k + 1;
end

figure(1);
subplot(2,1,1);  plot(t,x2vc,'-r',t,x2vn,'k');  grid;
ylabel('x2p');
subplot(2,1,2);  plot(t,x21c,'-r',t,x21n,'k');   grid;
ylabel('x21');
xlabel('Tiempo [seg]');
figure(2);
subplot(2,1,1);  plot(t,x1vc,'-r',t,x1vn,'k');    grid;
ylabel('x1p');
subplot(2,1,2);  plot(t,x10c,'-r',t,x10n,'k');   grid;
ylabel('x10');
xlabel('Tiempo [seg]');
figure(3);
plot(t,Fc,'-r',t,Fn,'k');grid;
ylabel('F');
xlabel('Tiempo [seg]');
figure(4);
plot(t,potc,'-r',t,potn,'k');grid;
ylabel('Potencia');
xlabel('Watts [W]');



   
       

       
       

