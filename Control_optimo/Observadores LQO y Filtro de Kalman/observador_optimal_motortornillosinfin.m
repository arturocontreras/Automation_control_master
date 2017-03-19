clear;
close all;
clc;

R = 1.1;
L = 0.001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.004;
m = 1.00;
c = 40;
r = 0.015;
alfa = 45*pi/180;
voltmax = 60;
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
   
r = 1*0.5;            % Posición deseada
voltmax = 1*24;       % Voltaje máximo
Fseca = 1.5*15;          % Fricción

%% Tiempos simulación
ti = 0;    tf = 10;   dt = 0.001;
t = ti:dt:tf;    t = t';
nt = length(t);

%% Diseño del Observador Optimal
W = [ 0.2
         0
         0.1 ];
     
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

[Aok Bok] = c2d(A-L*C,B,dt);
[Aok Lok] = c2d(A-L*C,L,dt); 
[Aok Wfok] = c2d(A-L*C,Wf,dt); 


xo = [ 0;  0;   0 ];
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('Control sin acción integral');   
% q1 = input('Peso q1  [x]     [1e5] : ');   
% q2 = input('Peso q2  [xp]   [0]     : ');   
% q3 = input('Peso q3  [i]      [0]     : ');

q1 = 1e5;   
q2 = 0;   
q3 = 0;


% q1 = 1e5;  q2 = 0;  q3 = 0;
Q = diag([ q1 q2 q3 ]);  
R = 1;
P = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*P;
k1 = K(1,1);    k2 = K(1,2);     k3 = K(1,3);

[ Ak Bk ]  = c2d(A,B,dt);
[ Ak Wfk ] = c2d(A,Wf,dt);
[ Ak Wk] = c2d(A,W,dt); 

k = 1;
x   = [ 0.1;  -0.1;  0.5 ];% Vector de estado inicial

fre = 0.5;
%r = 0.3*sin(2*pi*fre*t);

% Ruido de la planta
wmean = 0.1;
wstd = 0.1;
w = randn(nt,1);
w = (w-mean(w))*wstd/std(w) + wmean;

% Ruido del sensor
nmean = 0;
nstd = 0.1;
n = randn(nt,1);
n = (n-mean(n))*nstd/std(n) + nmean;
R = sum((n-nmean).*(n-nmean))/(nt-1);

for tt = ti:dt:tf
    
   y = C*x + n(k,1);
   yy(k,1) = y;
   xxo1(k,1) = xo(1,1);   xxo2(k,1) = xo(2,1);   xxo3(k,1) = xo(3,1);
   
   xx1(k,1) = x(1,1); xx2(k,1)  = x(2,1); xx3(k,1) = x(3,1);
   
   u = -K*xo + k1*r;
   
   if( u > voltmax)
       u = voltmax;
   elseif(u < -voltmax)
       u = -voltmax;
   end
   if(x(2,1) >= 0)
       Fs = Fseca;
   elseif(x(2,1) < 0)
       Fs = -Fseca;
   end
   
   x = Ak*x + Bk*u + Wfk*Fs + Wk*w(k,1);
   xo = Aok*xo + Bok*u + Lok*y +  Wfok*Fs; 
   k = k+1;
end


figure(1);
set(gcf,'numbertitle','off','name','Control usando observador OPTIMAL') 
subplot(3,1,1);
plot(t,xx1,'-b',t,xxo1,'r');grid;title('Posición m');
legend('real','obs')
%  hold on
%  plot(t,yy,'--g')
subplot(3,1,2);
plot(t,xx2,'-b',t,xxo2,'r');grid;title('Velocidad');
legend('real','obs')
subplot(3,1,3);
plot(t,xx3,'-b',t,xxo3,'r');grid;title('Corriente'); 
legend('real','obs')
   
   