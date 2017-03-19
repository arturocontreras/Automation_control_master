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
Fseca =  0.005*400;   % Variar el coeficente de 0 a 2.75  
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
      0  a32  a33 
      0  a22  a23]; 
Bs = [  0 
        0 
        b3 ]; 
C = [ 1  0  0
      0  1  0];
%%  
z = 1E-8;   % Analizar efecto 
A = [  0   0      1   
       0   a33 a32*z
       0   a23/z a22];  
B = [  0 
       b3*z 
       0 ]; 
   
A11 = A(1:2,1:2);     A12 = A(1:2,3);
A21 = A(3,1:2);       A22 = A(3,3);
B1 = B(1:2,1);
B2 = B(3,1);
Cr = A12;

%% Ingresamos pesos para el observador 
  
%q2 = input('Peso q2 (xp) : ');
q3 = input('Peso q3 (i)  : ');
Q = diag([q3 ]);
S = are(A22',Cr'*Cr,Q);
L = S*Cr';
ti = 0;    tf = 1;    dt = 0.001;
t = ti:dt:tf;    t = t';
nt = length(t);

Aw = A22 - L*A12;
Bw = B2 - L*B1;
Lw = A21 - L*A11 + A22*L - L*A12*L;


[Ak,Bk] = c2d(A,B,dt);  %Se discretiza
%[Ak,Wk] = c2d(A,Wf,dt);
[Ahk,Bhk] = c2d(Aw,Bw,dt);
[Ahk,Lhk] = c2d(Aw,Lw,dt);

%%
ti = 0; 
dt = 0.00001; 
tf = 1; 
t = ti:dt:tf; 
t = t'; 
nt = length(t); 


%% 

x  = 0.0;
xp = 0;
Pi = 1*Pe;
Po = 1*Pe;
xh(1,1) = 0;
xh(2,1) = z*(Pi - Po)-(Pio-Poo);
xh(3,1) = 0;

fre = 5;
u = 0.01*sin(2*pi*fre*t);
ruido = 0.02*randn(nt,1);

% ampxast = input('Introducir xast [-0.15 0.15 ] : ');
% nt = length(t);
% xast = ampxast*ones(nt,1);
wh = [ 0 ];
k = 1; 

for tt = ti:dt:tf 
  y = C*[ x; z*(Pi-Po); xp] + [1*0.04*randn(1,1); 0*0.005*randn(1,1)];  
  y1(k,1) = y(1,1);  
  y2(k,1) = y(2,1)/z;

  pos(k,1)    = x; 
  vel(k,1)    = xp; 
  Preio(k,1)   = Pi-Po; 
  
  xh = wh + L*y;
    
  xxo2(k,1) = xh(1,1);   
  %xxo3(k,1) = xh(2,1)/z ;%+(Pio-Poo);
   
  xsp = u(k,1); %  -K*[ error; xh(2,1); xh(3,1)]; 
  
  
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
  %xh = Aok*xh + Bok*u(k,1) + Lok*y;
  
      %x = Ak*x + Bk*u(k,1) + Wk*Ff;    %Planta
  wh = Ahk*wh + Bhk*u(k,1) + Lhk*y;   %Observador
   
  k = k + 1;    
end 
  
figure(1); 
subplot(3,1,1);    plot(t,pos,'b',t,y1,'--r'); 
ylabel('posicion'); 
subplot(3,1,2);  plot(t,vel,'b',t,xxo2,'r'); ylabel('velocidad'); 
subplot(3,1,3);  plot(t,Preio,'b',t,y2,'--r'); ylabel('pre_i-o'); 
% figure(2); 
% subplot(2,1,1);  plot(t,u); ylabel('u');
