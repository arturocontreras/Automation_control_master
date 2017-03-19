% Control Preview - Tiempo Continuo
% Motor con Tornillo Sinfin
% Pesos:   q1 = q2 = q3 = 0      q4 = 1e7
% Frecuencia de la referencia r:   0.2 Hz
% Probar con tiempo de preview tp:  0, 0.2, 0.4, 0.6, 0.7, 0.8, 1.0.

clear;
close all;
clc;

R = 1.8;
L = 0.000159;
Kt = 0.05567;
Kb = 0.05871;
I = 0.00004534;
p = 0.0028;
m = 0.218;
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
        
q1 = input('Peso q1 [0]   : ');
q2 = input('Peso q2 [0]   : ');
q3 = input('Peso q3 [0]   : ');
q4 = input('Peso q4 [1e6 - 1e7] : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];
P = are(Ai,Bi*inv(RR)*Bi',Q);
K = inv(RR)*Bi'*P; 
Ac = Ai - Bi*K;

%% Observador Optimal

C = [ 1   0    0 ];
Obs = [ C;   C*A;   C*A*A ];
detObs = det(Obs)

q1o = input('Peso q1o : ');
q2o = input('Peso q2o : ');
q3o = input('Peso q3o : ');
Qo = diag([ q1o q2o q3o ]);
Ro = eye(3);
So = are(A,inv(Ro),Qo);
L = inv(Ro)*So*C'*inv(C*C'); 

xo = [ 0;  0;   0 ];
 
%%
tp = input('Introducir tiempo preview : ');
dt = 0.0005;
np = round(tp/dt);
qq = P*Wri*dt;
for n = 1:np
   qq = [ qq  expm(Ac'*n*dt)*P*Wri*dt ];
end
Kpr = inv(RR)*Bi';

ti = 0;
tf = 44 + tp;
t = ti:dt:tf;
t = t';
nt =length(t);

%referencia
%% Figura a maquinar
%Tramo A
velx = 1;
X = [0 15]
Y = [0 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r1x = rx';
r1y = ry';

%Tramo B
velx = 1;
X = [15 10]
Y = [5 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r2x = rx';
r2y = ry';

%Tramo C
velx = 1;
X = [10 5]
Y = [15 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r3x = rx';
r3y = ry';

%Tramo D
vely = 1;
X = [5 5]
Y = [15 10]
t = (abs(Y(2)-Y(1)))/vely;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r4x = rx';
r4y = ry';

%Tramo E
velx = 1;
X = [5 0]
Y = [10 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r5x = rx';
r5y = ry';

%Tramo F
velx = 1;
X = [0 5]
Y = [15 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r6x = rx';
r6y = ry';

%Tramo G
velx = 1;
X = [0 5]
Y = [15 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r7x = rx';
r7y = ry';

%Tramo H
velx = 1;
X = [5 0]
Y = [5 0]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r7x = rx';
r7y = ry';

XX = [r1x;r2x;r3x;r4x;r5x;r6x;r7x;zeros(20000,1)];
YY = [r1y;r2y;r3y;r4y;r5y;r6y;r7y;zeros(20000,1)];

r = XX/100;

%%

[Ak,Bk] = c2d(A,B,dt);
x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;
kc = 1;
interr = 0;
J = 0;

[Aok Bok] = c2d(A-L*C,B,dt);
[Aok Lok] = c2d(A-L*C,L,dt); 


for tt = ti:dt:tf
    
   y = C*x + 0.001*rand(1,1);%medición
   posh(kc,1) = xo(1,1);
   velh(kc,1) = xo(2,1);
   amph(kc,1) = xo(3,1);
   
   pos(kc,1) = x(1,1);
   vel(kc,1) = x(2,1);
   amp(kc,1) = x(3,1);
   time(kc,1) = tt;
   
   interr = interr + (xo(1,1)-r(kc,1))*dt;
   ufb = -K*[ xo'  interr ]';
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
   
   J = J + 1/2*([ xo'  interr]*Q*[xo' interr]' + u'*RR*u)*dt; 
   volt(kc,1) = u;
   x = Ak*x + Bk*u;
   xo = Aok*xo + Bok*u + Lok*y; %observador  

   kc = kc + 1;
end
J = J/1e3;
r = r(1:nt,1);
maxu = max(volt);
disp(['Maximo voltaje : ',num2str(maxu)]);
disp(['Valor de J = ',num2str(J),'*10^3']);
figure(1);   plot(time,pos,time,posh,time,r);   grid;   title('Posicion'); 
legend('real','observado','referencia')
figure(2);   plot(time,volt);         grid;   title('Voltaje');




