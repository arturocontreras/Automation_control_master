
clear;
close all;
clc;

%%Motor x
R = 1.8;
L = 0.000159;
Kt = 0.05567;
Kb = 0.05871;
I = 0.00004534;
p = 0.0028;
m = 0.130;
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

Ax = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
Bx = [ 0
      0
      b31 ];
Wfx = [ 0
       w21       
       0 ];
    
Aix = [ 0   1   0   0 
       0  a22 a23  0
       0  a32 a33  0
       1   0   0   0 ]; 
Bix = [ 0
       0
       b31
       0 ]; 
Wrix = [ 0
        0       
        0
       -1 ];
Wfix = [ 0
        w21      
        0
        0 ];   

%Motor y
R = 1.92;
L = 0.0001801;
Kt = 0.09156;
Kb = 0.08925;
I = 0.000098342;
p = 0.0042;
m = 0.375 + 0.218 + m; %se suma la masa en X
c = 95;
r = 0.02;
alfa = 60*pi/180;
voltmax = 50;
d = m + 2*pi*I*tan(alfa)/(p*r);

a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;

Ay = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
By = [ 0
      0
      b31 ];
Wfy = [ 0
       w21       
       0 ];
    
Aiy = [ 0   1   0   0 
       0  a22 a23  0
       0  a32 a33  0
       1   0   0   0 ]; 
Biy = [ 0
       0
       b31
       0 ]; 
Wriy = [ 0
        0       
        0
       -1 ];
Wfiy = [ 0
        w21      
        0
        0 ]; 

%% Controladores optimales
        
% q1 = input('Peso q1 [0]   : ');
% q2 = input('Peso q2 [0]   : ');
% q3 = input('Peso q3 [0]   : ');
q1 = 0;
q2 = 0;
q3 = 0;
q4 = input('Peso q4 [1e6 - 1e7] : ');
Q = diag([ q1 q2 q3 q4 ]);
RR = [ 1 ];

%Motor x
Px = are(Aix,Bix*inv(RR)*Bix',Q);
Kx = inv(RR)*Bix'*Px; 
Acx = Aix - Bix*Kx;

%Motor y
Py = are(Aiy,Biy*inv(RR)*Biy',Q);
Ky = inv(RR)*Biy'*Py; 
Acy = Aiy - Biy*Ky;

dt = 0.0005;

%% Observadores Optimales
%Motor x
Cx = [ 1   0    0 ];
Obsx = [ Cx;   Cx*Ax;   Cx*Ax*Ax ];
detObsx = det(Obsx)

q1o = input('Peso q1o : ');
q2o = input('Peso q2o : ');
q3o = input('Peso q3o : ');
Qo = diag([ q1o q2o q3o ]);
Ro = eye(3);
So = are(Ax,inv(Ro),Qo);
Lx = inv(Ro)*So*Cx'*inv(Cx*Cx'); 

xo = [ 0;  0;   0 ];

%Motor y
Cy = [ 1   0    0 ];
Obsy = [ Cy;   Cy*Ay;   Cy*Ay*Ay ];
detObsy = det(Obsy)

Qo = diag([ q1o q2o q3o ]);
Ro = eye(3);
So = are(Ay,inv(Ro),Qo);
Ly = inv(Ro)*So*Cy'*inv(Cy*Cy'); 

yo = [ 0;  0;   0 ];

%% referencias
%Figura a maquinar
velx = 0.09;
vely = 0.09;
%Tramo A
X = [0 0.15];
Y = [0 0.05];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r1x = rx';
r1y = ry';

%Tramo B
X = [0.15 0.10];
Y = [0.05 0.15];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r2x = rx';
r2y = ry';

%Tramo C
X = [0.10 0.05];
Y = [0.15 0.15];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r3x = rx';
r3y = ry';

%Tramo D
X = [0.05 0.05];
Y = [0.15 0.10];
t = (abs(Y(2)-Y(1)))/vely;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r4x = rx';
r4y = ry';

%Tramo E
X = [0.05 0];
Y = [0.10 0.15];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r5x = rx';
r5y = ry';

%Tramo F
X = [0 0.05];
Y = [0.15 0.05];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r6x = rx';
r6y = ry';

%Tramo G
X = [0.05 0];
Y = [0.05 0];
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r7x = rx';
r7y = ry';

XX = [r1x;r2x;r3x;r4x;r5x;r6x;r7x];
YY = [r1y;r2y;r3y;r4y;r5y;r6y;r7y];

rx = XX;
ry = YY;

%% Tiempos
ti = 0;
tf = length(rx)*dt-1*dt;
t = ti:dt:tf;
t = t';
nt =length(t);

%% Discretizacion de la planta
[Axk,Bxk] = c2d(Ax,Bx,dt);
[Ayk,Byk] = c2d(Ay,By,dt);

%% Discretizacion de los observadores
[Axok Bxok] = c2d(Ax-Lx*Cx,Bx,dt);
[Axok Lxok] = c2d(Ax-Lx*Cx,Lx,dt);

[Ayok Byok] = c2d(Ay-Ly*Cy,By,dt);
[Ayok Lyok] = c2d(Ay-Ly*Cy,Ly,dt); 

x(1,1) = 0;
x(2,1) = 0;
x(3,1) = 0;
kc = 1;
interrx = 0;
Jx = 0;

y(1,1) = 0;
y(2,1) = 0;
y(3,1) = 0;
kc = 1;
interry = 0;
Jy = 0;

%Errores
e1=0;
e2=0;
rxs=0;
rys=0;

for tt = ti:dt:tf
   %%%%Motor X%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
   x_sal = Cx*x + 0.001*rand(1,1);%medición posicion en motor X 
   
   posx(kc,1) = x(1,1);
   velx(kc,1) = x(2,1);
   ampx(kc,1) = x(3,1);
   timex(kc,1) = tt;
   
   %Estados estimados
   posxh(kc,1) = xo(1,1);
   velxh(kc,1) = xo(2,1);
   ampxh(kc,1) = xo(3,1);
  
   interrx = interrx + (xo(1,1)-rx(kc,1))*dt;
   ufbx = -Kx*[ xo'  interrx ]';
   ux = ufbx;
   
   if( ux > voltmax )
      ux = voltmax;
   elseif( ux < -voltmax )
      ux = -voltmax;
   end
   
   potx(kc,1) = ampx(kc,1)*ux;%Potencia motor X
   potxh(kc,1) = ampxh(kc,1)*ux;%Potencia motor X estimado
   
   Jx = Jx + 1/2*([ xo'  interrx]*Q*[xo' interrx]' + ux'*RR*ux)*dt; 
   voltx(kc,1) = ux;
   x = Axk*x + Bxk*ux;
   xo = Axok*xo + Bxok*ux + Lxok*x_sal; %observador
   
   %%%%%% Motor Y %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   y_sal = Cy*y + 0.001*rand(1,1);%medición posicion en motor X
   
   posy(kc,1) = y(1,1);
   vely(kc,1) = y(2,1);
   ampy(kc,1) = y(3,1);
   timey(kc,1) = tt;
   
   %Estados estimados
   posyh(kc,1) = yo(1,1);
   velyh(kc,1) = yo(2,1);
   ampyh(kc,1) = yo(3,1);
   
   interry = interry + (yo(1,1)-ry(kc,1))*dt;
   ufby = -Ky*[ yo'  interry ]';
   uy = ufby;
   if( uy > voltmax )
      uy = voltmax;
   elseif( uy < -voltmax )
      uy = -voltmax;
   end
   
   poty(kc,1) = ampy(kc,1)*uy;%Potencia motor Y
   potyh(kc,1) = ampyh(kc,1)*uy;%Potencia motor Y estimado
   
   Jy = Jy + 1/2*([ yo'  interry]*Q*[yo' interry]' + uy'*RR*uy)*dt; 
   volty(kc,1) = uy;
   y = Ayk*y + Byk*uy;
   yo = Ayok*yo + Byok*uy + Lyok*y_sal; %observador 
    
   %Analisis errores %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
   e1=e1+(rx(kc,1)-x(1,1))^2;
   ee1(kc,1)=rx(kc,1)-x(1,1);
   e2=e2+(ry(kc,1)-y(1,1))^2;
   ee2(kc,1)=ry(kc,1)-y(1,1);
   et=e1+e2;
   
   rxs=rxs+rx(kc,1)^2;
   rys=rys+ry(kc,1)^2;
   rt=rxs+rys;
   
   kc = kc+ 1;
   
end

desemp=sqrt(et/rt)*100
max_error_x=max(ee1)
max_error_y=max(ee2)

%Motor x
Jx = Jx/1e3;
rx = rx(1:nt,1);
maxux = max(voltx);
disp(['Maximo voltaje x: ',num2str(maxux)]);
disp(['Valor de Jx = ',num2str(Jx),'*10^3']);
figure(1);   plot(timex,posx,timex,posxh,timex,rx);   grid;   title('Posicion');  
legend('real','observado','referencia')
figure(2);   plot(timex,voltx);         grid;   title('Voltaje');

%Motor y
Jy = Jy/1e3;
ry = ry(1:nt,1);
maxuy = max(volty);
disp(['Maximo voltaje y: ',num2str(maxuy)]);
disp(['Valor de Jy = ',num2str(Jy),'*10^3']);
figure(3);   plot(timey,posy,timey,posyh,timey,ry);   grid;   title('Posicion');  
legend('real','observado','referencia')
figure(4);   plot(timey,volty);         grid;   title('Voltaje');

%XY
figure(5); plot(rx,ry,posxh,posyh); 
hold on
plot(posxh,posyh,'linewidth',2)
hold off

%Comparación de potencias
figure(6)
plot(timex,potxh,timey,potyh)
legend('Potxh','Potyh')


