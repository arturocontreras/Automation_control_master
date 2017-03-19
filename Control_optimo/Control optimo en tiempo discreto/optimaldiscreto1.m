% Este programa aplica control optimal a un
% sistema de tiempo discreto. Se considera
% P = cte y se usa el comando dare().

clear;
clc;
close all;

k = 120;
m = 1;
c = 3;

a21 = -k/m;
a22 = -c/m;
b2 = 1/m;

A = [  0    1
      a21  a22 ];

B = [ 0 
      b2 ];

dt = 0.001;
[Ak,Bk] = c2d(A,B,dt);
            
q1 = input('Peso x : ');
q2 = input('Peso xp: ');

Q = [ q1  0
      0  q2 ];
      
R = [ 1 ];

P = dare(Ak,Bk,Q,R);

K = inv(R+Bk'*P*Bk)*Bk'*P*Ak;
% K = [ 0 0 ];

xini = [ 0.2
         0 ];
     
xast = [ 0
         0 ];
      
x =  xini;
niter = 1000;

for k = 1:(niter-1)
   x1n(k,1) = x(1,1);
   x2n(k,1) = x(2,1);
   un(k,1) = -[0 0]*x; 
   tt(k,1) = (k-1)*dt;
   x = Ak*x + Bk*un(k,1);  
end

x = xini;
xast = [ 0
         0 ];
for k = 1:(niter-1)
   x1c(k,1) = x(1,1);
   x2c(k,1) = x(2,1);
   uc(k,1) = -K*x; 
   nk(k,1) = k-1;
   x = Ak*x + Bk*uc(k,1);  
end

figure(1);
subplot(3,1,1);
plot(tt,x1n,'-r',tt,x1c,'-b');
ylabel('x1');
grid;
subplot(3,1,2);
plot(tt,x2n,'-r',tt,x2c,'-b');
ylabel('x2');
grid;
subplot(3,1,3);
plot(tt,un,'-r',tt,uc,'-b');
xlabel('Tiempo [seg]');
ylabel('u');
grid;
