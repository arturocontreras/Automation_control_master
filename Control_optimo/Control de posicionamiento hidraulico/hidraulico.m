% Control de sistema hidraulico
clear;
clc;
close all;

Area = 1.18E-3;     % D = 0.04    d = 0.01
Ai = Area;
Ao = Area;
maxelon = 0.20;     % Elongacion maxima
Vol = Area*maxelon;
beta = 1.25E9;
rho = 900;
cd = 16E-2;
w = 0.02;
c = 450;
m = 10;
Fseca =  0*400;   % Variar el coeficente de 0 a 2.75 
Pe = 1E5;          % Presion de escape
Ps = 10E5;         % Presion del tanque

xspmax = 0.02;
xmax = maxelon*0.80;    % 80% de elongacion maxima

%Punto de operación:
Pio = Ps/2;      % Probar valores
Poo = 2*Pe;
Pio = (Ps+Pe)/2;
Poo = (Ps+Pe)/2;
xspo = xspmax/2;

ai = cd*w*sqrt(2/rho*(Ps-Pio));
bi = -cd*w*xspo/sqrt(2*rho*(Ps-Pio));
ao = cd*w*sqrt(2/rho*(Poo-Pe));
bo = cd*w*xspo/sqrt(2*rho*(Poo-Pe));

a22 = -c/m;
a23 =  Area/m;
a24 = -Area/m;
a32 = -Area*beta/Vol;
a33 =  bi*beta/Vol;
a42 =  Area*beta/Vol;
a44 = -bo*beta/Vol;
b3  =  ai*beta/Vol;
b4  = -ao*beta/Vol;
w2 = -1/m;

A = [  0   1       0     0
         0   a22    a23   a24
         0   a32    a33    0
         0   a42    0     a44 ];
    
B = [  0
         0
         b3
         b4 ];


z = 1E-8;   % Analizar efecto
A = [  0    1           0         0
         0   a22      a23/z   a24/z
         0   a32*z   a33        0
         0   a42*z     0       a44 ];
    
B = [  0
         0
       b3*z
       b4*z ];
       
qx  = input('Introducir qx  [1e-1,1,10,1E2,1E3] : ');   
qv  = input('Introducir qv  [0] : ');      
qpi = input('Introducir qpi [0] : ');
qpo = input('Introducir qpo [0] : ');      
      
Q = diag([qx  qv  qpi  qpo]);
R = [ 1 ];

Pric = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*Pric;

ti = 0;
dt = 0.000015;
dt = 0.00001;

tf = 1;
t = ti:dt:tf;
t = t';
nt = length(t);

x  = 0.0;
xp = 0;
Pi = 1*Pe;
Po = 1*Pe;
ampxast = input('Introducir xast [-0.15 0.15 ] : ');
xast = ampxast*ones(nt,1);
% xast = ampxast*round((sin(2*3.141592*1*t)+1)/2);
% xast = ampxast * sin(2*pi*1*t);

k = 1;
for tt = ti:dt:tf
  pos(k,1)    = x;
  pos1(k,1)    = x;
  vel(k,1)    = xp;
  Prei(k,1)   = Pi;
  Preo(k,1)   = Po;
  error = x - xast(k,1);
  xsp = -K*[ error; xp;  z*(Pi-0*1*Pio); z*(Po - 0*1*Poo) ];
  if(xsp > xspmax)
     xsp = xspmax;
  elseif(xsp < -xspmax)
     xsp = -xspmax;
  end
  
  if(abs(x) >= xmax)
     xsp = 0;
  end
  u(k,1) = xsp;
  Vi = Vol + Ai*x;
  Vo = Vol - Ao*x;
  Volo(k,1) = Vo;
  if(xp >= 0)
     Ff = Fseca;
  elseif( xp < 0 )
     Ff = -Fseca;
  elseif( xp == 0 )
    Ff = Ai*Pi - Ao*Po;
  end
  x2p = Ai/m*Pi - Ao/m*Po - c/m*xp -Ff/m;
  if(xsp > 0)
     qi = cd*w*xsp*sqrt(2*(Ps-Pi)/rho);
     qo = cd*w*xsp*sqrt(2*(Po-Pe)/rho);
  elseif(xsp < 0)
     qi = cd*w*xsp*sqrt(2*(Pi-Pe)/rho);
     qo = cd*w*xsp*sqrt(2*(Ps-Po)/rho);
  elseif(xsp == 0)
     qi = 0;
     qo = 0;
  end  
  
  Pip = -Ai*beta/Vi*xp + beta/Vi*qi;
  Pop =  Ao*beta/Vo*xp - beta/Vo*qo;
  x  = x + xp*dt; 
  xp = xp + x2p*dt;
  Pi = Pi + Pip*dt;
  Po = Po + Pop*dt;
  if(Pi > Ps)
     Pi = Ps;
  elseif(Pi < Pe)
     Pi = Pe;
  end
  if(Po > Ps)
     Po = Ps;
  elseif(Po < Pe)
     Po = Pe;
  end
  k = k + 1;   
end

figure(1);
subplot(5,1,1);  plot(t,pos,t,xast);title('x');grid on;
subplot(5,1,2);  plot(t,vel);;title('xp');
subplot(5,1,3);  plot(t,Prei);;title('Pi');
subplot(5,1,4);  plot(t,Preo);;title('Po');
subplot(5,1,5);  plot(t,u);title('u');
