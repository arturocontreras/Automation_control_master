% Considerar Torque maximo = 15N-m
clear;
close all;
clc;
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

% M = [ M11  M12
%       M21  M22 ];
S = [ 1  -1
        0   1 ];
Si = inv(S);    
K11 = input('Ganancia K11 (fi1)   [10]: ');     % Los pesos son mayores cuando se sigue trayectoria
K12 = input('Ganancia K12 (fi2)   [10]: ');
K21 = input('Ganancia K21 (fi1p) [25]: ');
K22 = input('Ganancia K22 (fi2p) [25]: ');  
K1 = diag([ K11  K12 ]);
K2 = diag([ K21  K22 ]);

dt = 0.0005;

v = input('Velocidad eje x del robot: ');
Xc= 0.525; R=0.125;
ti=0; tf=pi/v;
t=ti:dt:tf; t=t'; nt=length(t);
theta = v*t;
xr = Xc + R*cos(theta);
yr = R*sin(theta);
% t1 = (0.650-0.525)/v;
% t2 = (0.650-0.400)/v;
% ti = 0;   tf = t2;
% tt1 = 0:dt:t1;           tt1 = tt1';
% tt2 = (t1+dt):dt:t2;     tt2 = tt2';
% x1 = -0.125/t1*tt1 + 0.65;
% x2 = 0.125/(t1-t2)*(tt2-t2) + 0.40;
% xr = [ x1;  x2 ];
% y1 = 0.10/t1*tt1;
% y2 = 0.10/(t1-t2)*(tt2-t2);
% yr = [ y1;   y2 ];
x2my2 = xr.^2 + yr.^2;
r1A = acos(xr./sqrt(x2my2));
r1B = acos((x2my2 + L1*L1 - L2*L2)./(2*L1*sqrt(x2my2)));
r2 = acos((x2my2 - (L1*L1 + L2*L2))/(2*L1*L2));
r2 = -r2;
r1 = atan2(yr,xr) + r1B;
r1 = real(r1);
r2 = real(r2);
nr = length(r1);
angast = [ r1  r2 ];
velast = [ zeros(nr,1)   zeros(nr,1) ];

%  r1 = 60*pi/180;
%  r2 = 30*pi/180;
%  ti = 0;  tf = 3;
%  t = ti:dt:tf;   t = t';
%  nt = length(t);
%  angast = [ r1*ones(nt,1)   r2*ones(nt,1) ];
%  velast  = [ zeros(nt,1)  zeros(nt,1) ];

fi1  = 0;    fi2  = 0;
fi1p = 0;    fi2p = 0;
ang = [ fi1   fi2 ]';
vel = [ fi1p  fi2p ]';


k = 1;
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
  T = Si*C - Si*M*((K1+K2*K1)*(ang-angast(k,:)') + K2*(vel-velast(k,:)'));

  %T = Si*C - Si*M*(K2*K1*(ang-angast(k,:)') + (K1+K2)*vel - K2*velast(k,:)');

  T1(k,1) = T(1,1);
  T2(k,1) = T(2,1);
   
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