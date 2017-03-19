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
Fseca = 0*400;   % Variar el coeficente de 0 a 2.75 
Pe = 1E5;          % Presion de escape
Ps = 8E5;         % Presion del tanque

xspmax = 0.02;
xmax = maxelon*0.80;    % 80% de elongacion maxima

ai = cd*w*sqrt(2/rho*(Ps-Ps/2));
bi = -cd*w*(xspmax/2)/sqrt(2*rho*(Ps-Ps/2));
ao = cd*w*sqrt(2/rho*(2*Pe-Pe));
bo = cd*w*(xspmax/2)/sqrt(2*rho*(2*Pe-Pe));

a22 = -c/m;
a23 =  Area/m;
a24 = -Area/m;
a32 = -Area*beta/Vol;
a33 =  bi*beta/Vol;
a42 =  Area*beta/Vol;
a44 = -bo*beta/Vol;
b3  =  ai*beta/Vol;
b4  = -ao*beta/Vol;

z = 1E8;
zm1 = 1E-8;

Aint = [  0   1   0        0       0
          0   0   1        0       0
          0   0   a22      a23*z   a24*z
          0   0   a32*zm1  a33     0
          0   0   a42*zm1  0       a44 ];
    
Bint = [  0
          0
          0
          b3*zm1
          b4*zm1 ];
       
qxi = input('Introducir qxi [0.8e2 ] : ');   
qx  = input('Introducir qx  [0.0] : ');   
qv  = input('Introducir qv  [0.0] : ');      
qpi = input('Introducir qpi [0.0] : ');
qpo = input('Introducir qpo [0.0] : ');      
      
Qi = diag([qxi qx qv qpi qpo]);
Ri = [ 1 ];

Pi = are(Aint,Bint*inv(Ri)*Bint',Qi);
K = inv(Ri)*Bint'*Pi;

ti = 0;
dt = 0.00001;
dt = 0.00005;
tf = 2;
t = ti:dt:tf;   t = t';
nt = length(t);

Pe = 1E5;
Ps = 8E5;
x  = 0.0;
xp = 0;
pi = 1*Pe;
po = 1*Pe;
xamp = input('Introducir xast [-0.15 0.15 ] : ');
xast = xamp*ones(nt,1);

interr = 0;
k = 1;
for tt = ti:dt:tf
  pos(k,1)    = x; 
  vel(k,1)    = xp;
  Prei(k,1)   = pi;
  Preo(k,1)   = po;
  error = x - xast(k,1);
  interr = interr + error*dt;
  xsp = -K*[ interr;  x; xp;  zm1*(pi-0*Pe); zm1*(po-0*Pe) ];
  if(xsp > xspmax)
     xsp = xspmax;
  elseif(xsp < -xspmax)
     xsp = -xspmax;
  end
  u(k,1) = xsp;
  Vi = Vol + Ai*x;
  Vo = Vol - Ao*x;
  Volo(k,1) = Vo;
  if(xp > 0)
     Ff = Fseca;
  elseif( xp < 0 )
     Ff = -Fseca;
  elseif( xp == 0 )
    Ff = Ai*pi - Ao*po;
  end
  x2p = Ai/m*pi - Ao/m*po - c/m*xp -Ff/m;
  if(xsp > 0)
     qi = cd*w*xsp*sqrt(2*(Ps-pi)/rho);
     qo = cd*w*xsp*sqrt(2*(po-Pe)/rho);
  elseif(xsp < 0)
     qi = cd*w*xsp*sqrt(2*(pi-Pe)/rho);
     qo = cd*w*xsp*sqrt(2*(Ps-po)/rho);
  elseif(xsp == 0)
     qi = 0;
     qo = 0;
  end  
  
  pip = -Ai*beta/Vi*xp + beta/Vi*qi;
  pop =  Ao*beta/Vo*xp - beta/Vo*qo;
  x  = x + xp*dt; 
  xp = xp + x2p*dt;
  pi = pi + pip*dt;
  po = po + pop*dt;
  if(pi > Ps)
     pi = Ps;
  elseif(pi < Pe)
     pi = Pe;
  end
  if(po > Ps)
     po = Ps;
  elseif(po < Pe)
     po = Pe;
  end
  k = k + 1;   
end

figure(1);
subplot(4,1,1);  plot(t,pos,t,xast);
subplot(4,1,2);  plot(t,vel);
subplot(4,1,3);  plot(t,Prei);
subplot(4,1,4);  plot(t,Preo);
figure(2);
plot(t,u);
