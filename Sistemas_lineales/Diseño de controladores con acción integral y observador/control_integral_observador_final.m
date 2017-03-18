clear; close all; clc;
R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.004;
m = 1.00;
c = 40;
r = 0.015;
alfa = 45*pi/180;
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
C=[1 0 0];
D=[0];

%sistema aumentado

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
Ci = [ 1 0  0  0 ];
Di = [ 0 ];

q1 = 1e6 % 0.905e6   1e6
q2 = 0       % 0
q3 = 0       % 0
q4 = 2.5e6  % 2.77e6   3e6

Qi = diag([ q1 q2 q3 q4 ]);  
RRi = 1;
Pi = are(Ai,Bi*inv(RRi)*Bi',Qi);
Ki = inv(RRi)*Bi'*Pi;
k1 = Ki(1,1);

q1o = 1e2;
q2o = 1e2;
q3o = 1e2;
Qo = diag([ q1o q2o q3o ]);
S = are(A',C'*C,Qo);
L = S*C';
ti = 0;    tff = 10;   dt = 0.001;
t = ti:dt:tff;    t = t';
r = 0.3;            % Posición deseada
vmax = 24;       % Voltaje máximo
Fs = 0;         % Fricción   0, 0.5, 1.0, 1.5

[ Ak Bk ] = c2d(A,B,dt);
[ Ak Wk ] = c2d(A,Wf,dt);
[Aok Bok] = c2d(A-L*C,B,dt);
[Aok Lok] = c2d(A-L*C,L,dt);
x  = [0;0;0];     % Vector de estado inicial
xo = [0;0;0];     % Vector inicial de variables estimadas
ru = r/2*square(2*pi*1/3*t)+r/2;
int_err=0;
k = 1;

for tt = ti:dt:tff
   xx1(k,1) = x(1,1);
   xx2(k,1) = x(2,1);
   xx3(k,1) = x(3,1);
   xx1o(k,1)= xo(1,1);
   xx2o(k,1)= xo(2,1);
   xx3o(k,1)= xo(3,1);
   
   
   y = C*x + 0.01*randn(1,1);
   sensor(k,1) = y;
   int_err = int_err + (xo(1,1)-ru(k))*dt;
   u = -Ki(1,1:3)*xo - Ki(1,4)*int_err;
   %u=vmax*square(2*pi*1/3*tt); 
   if(u > vmax)
       u = vmax;
    elseif(u < -vmax)   
       u = -vmax;
    end
    uu(k,1) = u;
     if(x(2,1) >= 0)
        Fsk = Fs;
    elseif(x(2,1) < 0)
        Fsk = -Fs;
    end
    x = Ak*x + Bk*u + Wk*Fsk;
    xo = Aok*xo + Bok*u + Lok*y;
    
    potencia(k,1) = x(3,1)*u;
    
    k = k + 1;
end
% Determinación de errror estacionario
sobreimpulso = ((max(xx1) - r)/r)*100;
disp(['Sobreimpulso: ',num2str(sobreimpulso),'%']);
figure(1);

subplot(2,1,1);
%plot(t,xx1,'r',t,xx1o,'-b',t,sensor,t,ru,'k','LineWidth',2);    grid;
plot(t,xx1,'r',t,xx1o,'-b',t,ru,'k','LineWidth',2);    grid;
aaaa = xx1o;
axis([0 10 0 0.35])
title('Posicion'); legend('Planta','Observador')
subplot(2,1,2);  
plot(t,uu);      grid;
title('Voltaje')

figure(2); 
plot(t,potencia);      grid;
title('Potencia')

figure(3); 
subplot(211)
plot(t,xx2,'r',t,xx2o,'-b' );      grid;
title('Velocidad')
legend('vel modelo','vel estimado')
subplot(212)
plot(t,xx3,'r',t,xx3o,'-b' );      grid;
title('Corriente')
legend('i modelo','i estimado')

% Diagrama de Bode
Acl = [A       -B*Ki(1,1:3)       -B*Ki(1,4)
       L*C     A-B*Ki(1,1:3)-L*C -B*Ki(1,4)
       [0 0 0]  [1 0 0]            0];
   
Bcl = [[0 0 0]' ; [0 0 0]' ; -1];

Ccl = [C [0 0 0] 0];

Dcl = 0;

fre = 0:0.1:20;   fre = fre';
wrs = 2*pi*fre;
[ mag fase ] = bode(Acl,Bcl,Ccl,Dcl,1,wrs);
[num den] = ss2tf(Acl,Bcl,Ccl,Dcl);
sys = tf(num,den);
Ancho_banda = bandwidth(sys);
Ancho_banda  = Ancho_banda/(2*pi);

figure(4);
subplot(2,1,1);  semilogx(fre,20*log10(mag));    grid;
title(['El ancho de banda es ' num2str(Ancho_banda) 'Hz'])
subplot(2,1,2);  semilogx(fre,fase);   grid;



