% r = 0.5
% t_asentamiento < 4 seg
% sobreimpulso   < 1%
% error estacionario: 0%
% abs(u) < 50 volt
% pot < 250 watts
clear;
close all;
clc;
R = 1.1;            L = 0.0001;
Kt = 0.0573;        Kb = 0.05665;
I = 4.326e-5;       p = 0.0025;
m = 1.00;           c = 40;
r = 0.01;           alfa = 45*pi/180;
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

H = inv([A^2*B  A*B  B]);
Ab = H*A*inv(H);
Bb = H*B;
% a2 = -Ab(1,1);
% a1 = -Ab(2,1);
% a0 = -Ab(3,1);
polosA = eig(A);
denA = poly(polosA);
a2 = denA(1,2);
a1 = denA(1,3);
a0 = denA(1,4);

T = [0 0 1
     0 1 a2
     1 a2 a1];
T = inv(T);
Abb = T*Ab*inv(T);
Bbb = T*Bb;
polos = [ -2+i  -2-i  -4];
alfa = input('Factor de polos: ');
polos = alfa*polos;
dendes = poly(polos);
b2 = dendes(1,2);
b1 = dendes(1,3);
b0 = dendes(1,4);
Kz = [b2-a2  b1-a1  b0-a0];
K = Kz*T*H;
Acl = A - B*K;

ti = 0;    tf = 10;
dt = 0.0002;
[ Ak  Bk ]  = c2d(A,B,dt);
[ Ak  Wfk ] = c2d(A,Wf,dt); 
Fseca = 0*2.5;
xast = 0.5;
k = 1;
x(1,1) = 0;    x(2,1) = 0;    x(3,1) = 0;
for tt = ti:dt:tf
    x1(k,1) = x(1,1);   x2(k,1) = x(2,1);   x3(k,1) = x(3,1);    
    t(k,1) = tt;
    u = -K*x + K(1,1)*xast;
    if(u > 50)
       u = 50; 
    elseif( u < -50)
       u = -50;
    end
    uu(k,1) = u;
    pot(k,1) = u*x(3,1);
    if(x(2,1) >= 0)
        Fs = Fseca;
    elseif( x(2,1) < 0)
        Fs = -Fseca;
    end
    x = Ak*x + Bk*u + Wfk*Fs;
    k = k + 1;  
end
figure(1);plot(t,x1);title('Pos');grid;       figure(2);plot(t,x2);title('Vel');grid;
figure(3);plot(t,x3);title('Amp');grid;       figure(4);plot(t,uu);title('Volt');grid;
figure(5);plot(t,pot);title('Pot');grid;  

