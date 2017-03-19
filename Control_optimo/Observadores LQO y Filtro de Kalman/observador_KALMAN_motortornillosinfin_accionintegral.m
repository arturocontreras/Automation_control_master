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
% xp = Ax + Bu + WfF + Ww
W = [ 0.2
         0
         0.1 ];
     
C = [ 1   0    0 ];
Obs = [ C;   C*A;   C*A*A ];
detObs = det(Obs)

%% Modelo ruido

% Ruido de la planta
wmean = 1;
wstd = 2;
w = randn(nt,1);
w = (w-mean(w))*wstd/std(w) + wmean;
Q = sum((w-wmean).*(w-wmean))/(nt-1);

% Ruido del sensor
nmean = 0;
nstd = 0.1;
n = randn(nt,1);
n = (n-mean(n))*nstd/std(n) + nmean;
R = sum((n-nmean).*(n-nmean))/(nt-1);

%% Observador 
So = are(A',C'*inv(R)*C,W*Q*W');
L = So*C'*inv(R);

[Aok Bok] = c2d(A-L*C,B,dt);
[Aok Lok] = c2d(A-L*C,L,dt); 
[Aok Wok] = c2d(A-L*C,W,dt); 
[Aok Wfok] = c2d(A-L*C,Wf,dt); 

xo = [ 0;  0;   0 ];
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('Control sin acción integral');   
% q1 = input('Peso q1  [x]     [1e5] : ');   
% q2 = input('Peso q2  [xp]   [0]     : ');   
% q3 = input('Peso q3  [i]      [0]     : ');
% n   = input('Peso n    [pot]  [0]     : ');

q1 = 1e5;   
q2 = 0;   
q3 = 0;
nn  = 0;

% q1 = 1e5;  q2 = 0;  q3 = 0;
Q = diag([ q1 q2 q3 ]);  
RR = 1;
N = [ 0;  0;  nn ];
AA = A - B*inv(RR)*N';
QQ = Q - N*inv(RR)*N';
P = are(AA,B*inv(RR)*B',QQ);
K = inv(RR)*(B'*P + N');
k1 = K(1,1);    k2 = K(1,2);     k3 = K(1,3);

[ Ak Bk ]  = c2d(A,B,dt);
[ Ak Wfk ] = c2d(A,Wf,dt);
[ Ak Wk ] = c2d(A,W,dt); 

k = 1;
x   = [ 0.1;  -0.1;  0.5 ];% Vector de estado inicial


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
   
   x = Ak*x + Bk*u + Wk*w(k,1) + Wfk*Fs;
   xo = Aok*xo + Bok*u + Lok*y + Wok*wmean + Wfok*Fs; 
   k = k+1;
end

% Determinación de errror estacionario
k = k - 1;
errest = ((xx1(k,1) - r)/r)*100;
disp(['Error estacionario: ',num2str(errest),'%']);

% Determinación de sobreimpulso
posmax = max(xx1);
if(posmax > r)
   sobreimpulso = (posmax-r)/r*100;   
   disp(['Sobreimpulso: ',num2str(sobreimpulso),'%']); 
else
   disp('Sobreimpulso 0.00%');     
end

figure(1);
subplot(3,1,1);
plot(t,xx1,'r',t,xxo1,'-b');grid;title('Posición m');
subplot(3,1,2);
plot(t,xx2,'r',t,xxo2,'-b');grid;title('Velocidad');
subplot(3,1,3);
plot(t,xx3,'r',t,xxo3,'-b');grid;title('Corriente'); 

   
   