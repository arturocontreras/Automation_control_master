% Comparacion de Model Follow control con
% control con acción integral

clear;
clc;
close all;

%%%%%%%%%%%%%%%%%%%%%%
%% Modelo de referencia:  Sky-hook Damper
eta = 0.90;
f = 1.5*0.4;   % Cambiar factor para hacer más rápida
             % la respuesta del sistema controlado (Probar con 1 - 1.5)
w = 2*pi*f;
Am = [   0      1
       -w*w    -2*eta*w ];
Bm = [ 0
       w*w ];
Cm = [ 1  0 ];

dt = 0.001;    ti = 0;     tf = 10;
t = ti:dt:tf;   t = t';   nt = length(t);
rast = 0.3*ones(nt,1);
[Amk,Bmk] = c2d(Am,Bm,dt);
xm = [ 0
          0 ];
k = 1;
for tt = ti:dt:tf
   xm1(k,1) = xm(1,1);      xm2(k,1) = xm(2,1);
   xm = Amk*xm + Bmk*rast(k,1); 
   k = k + 1;   
end
figure(1);   plot(t,xm1);
title('Posicion - Modelo Deseado');
grid;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Motor

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.0075;
m = 0.5*1.00;
c = 10;    %Fricción viscosa aparece dentro del modelo
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
      0  a32 a33 ];%Matriz A
B = [ 0
      0
      b31 ];%Matriz B
Wf = [ 0
       w21       
       0 ];%Fricción seca actúa como una perturbación no lineal
C = [ 1  0  0 ];   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('Control Feedbak + Feedforward ');
disp(' ');

%% controlador

q = 1e9; %input('Peso del error [y-ym]   [1e9]: ');     % 4e8
Q = [ q ];
QQ = C'*Q*C;
RR = [ 1 ];
P11 = are(A,B*inv(RR)*B',QQ);
APR = A'-P11*B*inv(RR)*B';
CQCm = -C'*Q*Cm;
P12 = lyap(APR,Am,CQCm);
Kfb = inv(RR)*B'*P11;
Kff = inv(RR)*B'*P12;

%% observador
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
xo = [ 0;  0;   0 ];

%%
umax = 24;
Pot = 200;
Fric = 0*10;   
[Ak Bk] = c2d(A,B,dt);
[Ak Wk] = c2d(A,Wf,dt);
x   = [ -0.1;  0.1;  0.1 ];
xm = [ 0;  0 ];
k = 1;
for tt = ti:dt:tf
    y = C*x + 0.01*randn(1,1);
    yy(k,1) = y;
    xm1(k,1) = xm(1,1);
    xm2(k,1) = xm(2,1);
    xx1(k,1) = x(1,1);       xx2(k,1) = x(2,1);      xx3(k,1) = x(3,1);
    xxo1(k,1) = xo(1,1);   xxo2(k,1) = xo(2,1);   xxo3(k,1) = xo(3,1);
    time(k,1) = tt;
    u = -Kfb*xo - Kff*xm;        %  q = 1e8
%    if(tt > 5)     % Analizar efecto cuando se corta voltaje 
%        u = 0;
%    end
    if(u > umax)
       u = umax;
    elseif(u < -umax)
       u = -umax;
    end
    if(x(2,1) >= 0)
        F = Fric;
    elseif(x(2,1) < 0)
        F = -Fric;
    end
    uc(k,1) = u; 
    pot(k,1) = u*x(3,1);
    x = Ak*x + Bk*u + Wk*F;
    xm = Amk*xm + Bmk*rast(k,1);  
    
    xo = Aok*xo + Bok*u + Lok*y; 
    k = k + 1;
end

figure(1);
plot(t,xx1,'-r',t,xxo1,'-b',t,xm1,'--g');     grid;      title('Posición m');
legend('pos real','pos obs','pos modelo')
% plot(t,xx1,'-r',t,xxo1,'-b',t,yy,'--g');     grid;      title('Posición m');
% legend('pos real','pos obs','pos medida')
figure(2);
plot(t,xx2,'-r',t,xxo2,'-b');     grid;      title('Velocidad');
legend('vel real','vel obs')
figure(3);
plot(t,xx3,'-r',t,xxo3,'-b');     grid;      title('Corriente');
legend('I vel real','I obs')
