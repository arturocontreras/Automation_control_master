% Control LQR de motor con tornillo sinfin. 
% Sin accion integral.
% Se incluye potencia en la funci�n de costo
%  J >> x'Qx + 2x'Nu + u'Ru

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
   
r = 1*0.5;            % Posici�n deseada
voltmax = 1*24;       % Voltaje m�ximo
Fseca = 0*15;          % Fricci�n
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Control sin acci�n integral');   
q1 = input('Peso q1  [x]     [1e5] : ');   
q2 = input('Peso q2  [xp]   [0]     : ');   
q3 = input('Peso q3  [i]      [0]     : ');
n   = input('Peso n    [pot]  [0]     : ');

% q1 = 1e5;  q2 = 0;  q3 = 0;
Q = diag([ q1 q2 q3 ]);  
RR = 1;
N = [ 0;  0;  n ];
AA = A - B*inv(RR)*N';
QQ = Q - N*inv(RR)*N';
P = are(AA,B*inv(RR)*B',QQ);
K = inv(RR)*(B'*P + N');
k1 = K(1,1);    k2 = K(1,2);     k3 = K(1,3);
ti = 0;    tf = 10;   dt = 0.001;
t = ti:dt:tf;    t = t';
[ Ak Bk ]  = c2d(A,B,dt);
[ Ak Wk ] = c2d(A,Wf,dt);
x = [ 0.0;  0;  0 ];     % Vector de estado inicial
k = 1;
for tt = ti:dt:tf
   pos(k,1) = x(1,1);
   vel(k,1)  = x(2,1);
   cor(k,1) = x(3,1);
   u = -K*x + k1*r;
   if( u > voltmax)
       u = voltmax;
   elseif(u < -voltmax)
       u = -voltmax;
   end
   volt(k,1) = u;
   pot(k,1) = u*x(3,1);
   if(x(2,1) >= 0)
       Fs = Fseca;
   elseif(x(2,1) < 0)
       Fs = -Fseca;
   end
   x = Ak*x + Bk*u + Wk*Fs;
   k = k+1;
end

% Determinaci�n de errror estacionario
k = k - 1;
errest = ((pos(k,1) - r)/r)*100;
disp(['Error estacionario: ',num2str(errest),'%']);

% Determinaci�n de sobreimpulso
posmax = max(pos);
if(posmax > r)
   sobreimpulso = (posmax-r)/r*100;   
   disp(['Sobreimpulso: ',num2str(sobreimpulso),'%']); 
else
   disp('Sobreimpulso 0.00%');     
end

figure(1);
subplot(3,1,1);  plot(t,pos);    ylabel('Posicion');   grid;
title('Control sin Acci�n Integral');
subplot(3,1,2);  plot(t,vel);    ylabel('Velocidad');
subplot(3,1,3);  plot(t,cor);    ylabel('Corriente');
xlabel('Tiempo');   
figure(2);
subplot(2,1,1),   plot(t,volt);  ylabel('Voltaje');
title('Control sin Acci�n Integral');
subplot(2,1,2);   plot(t,pot);   ylabel('Potencia');
xlabel('Tiempo');   
   