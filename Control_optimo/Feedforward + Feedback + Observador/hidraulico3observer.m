% Control de sistema hidraulico 
clear; clc; close all;  
  
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
Fseca =  0.1*400;   % Variar el coeficente de 0 a 2.75  
Pe = 1E5;             % Presion de escape 
Ps = 10E5;            % Presion del tanque 
  
xspmax = 0.02; 
xmax = maxelon*0.80;    % 80% de elongacion maxima 
  
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
a32 = -Area*2*beta/Vol; 
a33 = -bo*beta/Vol; 
b3  =  (ai+ao)*beta/Vol;
w2 = -1/m; 
  
As = [0   1    0 
      0  a22  a23 
      0  a32  a33]; 
Bs = [  0 
        0 
        b3 ]; 
C = [ 1  0  0 
      0  0  1 ];
%%  
z = 1E-8;   % Analizar efecto 
A = [  0   1      0   
       0   a22    a23/z  
       0   a32*z  a33 ];  
B = [  0 
       0 
       b3*z ]; 
%% controlador        
% qx   = input('Introducir qx       [1e-1,1,10,1E2,1E3] : ');    
% qv   = input('Introducir qv       [0] : ');       
% qpio = input('Introducir q(pi-po) [0] : ');    
 
qx  = 1e2;   
qv  = 0;      
qpio = 0;    
       
Q = diag([qx  qv  qpio ]); 
R = [ 1 ]; 
  
Pric = are(A,B*inv(R)*B',Q); 
K = inv(R)*B'*Pric; 

%% Ingresamos pesos para el observador 
  
q1o = input('Peso q1o : '); 
q2o = input('Peso q2o : '); 
q3o = input('Peso q3o : '); 

Q = diag([ q1o q2o q3o]); 

Sric = are(A',C'*C,Q);
L = Sric*C';
%%
ti = 0; 
dt = 0.00001; 
tf = 1; 
t = ti:dt:tf; 
t = t'; 
nt = length(t); 

%% Discretizamos matrices de observador 
  
[Aok Bok] = c2d(A-L*C,B,dt); 
[Aok Lok] = c2d(A-L*C,L,dt); 
%% 

x  = 0.0;
xp = 0;
Pi = 1*Pe;
Po = 1*Pe;
xh(1,1) = 0;
xh(2,1) = 0;
xh(3,1) = z*(Pi - Po)-(Pio-Poo);

ampxast = input('Introducir xast [-0.15 0.15 ] : ');
nt = length(t);
xast = ampxast*ones(nt,1);
k = 1; 

for tt = ti:dt:tf 
  y = C*[x; xp; z*(Pi-Po)] + [0.1*randn(1,1); 0*0.0005*randn(1,1)];  
  y1(k,1) = y(1,1);  
    
  pos(k,1)    = x; 
  vel(k,1)    = xp; 
  Preio(k,1)   = Pi-Po; 
  
  xxo1(k,1) = xh(1,1);  
  xxo2(k,1) = xh(2,1);   
  xxo3(k,1) = xh(3,1)/z +(Pio-Poo);
  
  error = xh(1,1) - xast(k,1); 
   
  xsp = -K*[ error; xh(2,1); xh(3,1)]; 
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
  xh = Aok*xh + Bok*u(k,1) + Lok*y;
  k = k + 1;    
end 
  
figure(1); 
subplot(4,1,1);    plot(t,pos,'b',t,xxo1,'r'); 
ylabel('posicion'); 
subplot(4,1,2);  plot(t,vel,'b',t,xxo2,'r'); ylabel('velocidad'); 
subplot(4,1,3);  plot(t,Preio,'b',t,xxo3,'r'); ylabel('preio'); 
%subplot(4,1,4);  plot(t,Preo); ylabel('pre_o'); 
subplot(4,1,4);  plot(t,u); ylabel('u');


