% aplicando control optimo al sistema de poscionamiento del brazo de 2DF
clear;
clc;
close all;

m1 = 0.15;
L1 = 0.35;
l1 = 0.16;
I1 = 4.1e-3;
m2 = 0.12;
L2 = 0.30;
l2 = 0.12;
I2 = 3.2e-3;
M11 = I1 + m1*l1*l1 + m2*L1*L1 + m2*L1*l2;
M12 = m2*L1*l2;
M21 = I2 + m2*l2*l2 + m2*L1*l2;
M22 = I2 + m2*l2*l2;

M = [ M11  M12
       M21  M22 ];
S = [ 1  -1
      0   1 ];
invM=inv(M);
    
A=[ zeros(2,2) eye(2,2)
    zeros(2,2) zeros(2,2) ];
B=[ zeros(2,2)
      invM*S   ];

% ingresar pesos de variable para minimizacion de costo  
q1 = input('Ganancia K1 (fi1)  10: ');
q2 = input('Ganancia K2 (fi2)  10: ');
q3 = input('Ganancia K3 (fi1p)  0: ');
q4 = input('Ganancia K4 (fi2p)  0: ');
R=eye(2);
Q = diag([ q1 q2 q3 q4 ]);
P = are(A,B*inv(R)*B',Q);
K = inv(R)*B'*P;

%ingresamo velocidad y generacion de vector de timpo
v = input('Velocidad eje x del robot [0.1]: ');
Xc=0.525; R=0.125;
ti=0;dt = 0.005; tf=pi/v;
t=ti:dt:tf; t=t';
nt = length(t);
% posiciones deseadas
theta=v*t;
xr= Xc + R*cos(theta);
yr= R*sin(theta);

% poscion deseada en angulo (phi1 y ph2)
x2my2 = xr.^2 + yr.^2;
r1A = acos(xr./sqrt(x2my2));%BOC
r1B = acos((x2my2 + L1*L1 - L2*L2)./(2*L1*sqrt(x2my2)));%BOA
r2 = acos((x2my2 - (L1*L1 + L2*L2))/(2*L1*L2));%phi2
r2 = -r2;%-r2;
r1 =atan2(yr,xr) + r1B; %r1A- r1B;
r1 = real(r1);
r2 = real(r2);
nr = length(r1);
angast = [ r1  r2 ];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[Ak,Bk] = c2d(A,B,dt);  %Se discretiza

%condiciones iniciales
fi1  = 0;    fi2  = 0;
fi1p = 0;    fi2p = 0;

x=[fi1; fi2; fi1p; fi2p];
k = 1;
K(2,1)=0;

fi1  = 0;    fi2  = 0;
fi1p = 0;    fi2p = 0;
ang = [ fi1   fi2 ]';
vel = [ fi1p  fi2p ]';

%

for tt = ti:dt:tf
   phi1(k,1) = fi1;     phi2(k,1) = fi2;   t(k,1) = tt;
   fi1 = ang(1,1);    fi2 = ang(2,1);
   fi1p = vel(1,1);   fi2p = vel(2,1);
   M11a = I1 + m1*l1*l1 + m2*L1*L1 + m2*L1*l2 * cos(fi2);
   M12a = m2*L1*l2*cos(fi2);
   M21a = I2 + m2*l2*l2 + m2*L1*l2*cos(fi2);
   M22a = I2 + m2*l2*l2;
   M = [ M11a  M12a
            M21a  M22a ];
        
   C1 = -m2*L1*l2*(fi1p+fi2p)^2*sin(fi2);
   C2 = m2*L1*l2*fi1p*fi1p*sin(fi2);
   C = [ C1
           C2 ];

   T = -K*[fi1-r1(k,1); fi2-r2(k,1);fi1p;fi2p];
   
   T1(k,1)=T(1,1);
   T2(k,1)=T(2,1);
   
   accel = inv(M)*(-C+S*T);
   ang = ang + dt*vel;
   vel = vel + dt*accel;
   k = k + 1;  
end

xx = L1*cos(phi1) + L2*cos(phi1 + phi2);
yy = L1*sin(phi1) + L2*sin(phi1 + phi2);

phi1 = phi1*180/pi;
phi2 = phi2*180/pi;
r1g = r1*180/pi;
r2g = r2*180/pi;

figure(1);
subplot(2,1,1);  plot(t,phi1,t,r1g);
legend('phi1 real','phi1 est')
subplot(2,1,2);  plot(t,phi2,t,r2g);
legend('phi2 real','phi2 est')

figure(2);
plot(t,T1,t,T2);   title('Torques')
legend('T1','T2')

figure(3);
plot(xx,yy,xr,yr);
legend('referencia','real')

error=sqrt((xr-xx).^2 + (yr-yy).^2);
errormax=max(error)*1000;
disp(['error máximo      [mm]: ', num2str(errormax)])

% calculamos el desempeño
errorx  = (xr-xx).^2;
errory  = (yr-yy).^2;
errorxy = errorx + errory;
rrx     = xr.^2;
rry     = yr.^2;
sumrx   = sum(rrx);
sumry   = sum(rry);
desmp   = sqrt(sum(errorxy)/(sumrx+sumry))*100;
disp(['desempeño       [<=5%]: ',num2str(desmp)]) 