clear;
close all;
clc;

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

   
r = 0.5;            % Posición deseada
voltmax = 24;       % Voltaje máximo
Fseca = 0.*12;         % Fricción   0, 0.5, 1.0, 1.5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Control sin acción integral');   
% q1 = input('Peso q1: ');   
% q2 = input('Peso q2: ');   
% q3 = input('Peso q3: ');
q1 = 1e5;  q2 = 0;  q3 = 0;
Q = diag([ q1 q2 q3 ]);  
RR = 1;
P = are(A,B*inv(RR)*B',Q);
K = inv(RR)*B'*P;
k1 = K(1,1);    k2 = K(1,2);     k3 = K(1,3);
ti = 0;    tf = 10;   dt = 0.001;
t = ti:dt:tf;    t = t';
[ Ak Bk ] = c2d(A,B,dt);
[ Ak Wk ] = c2d(A,Wf,dt);
x = [ 0;  0;  0 ];     % Vector de estado inicial
k = 1;
for tt = ti:dt:tf
   pos(k,1) = x(1,1);
   vel(k,1) = x(2,1);
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

% Determinación de errror estacionario
k = k - 1;
errest = ((pos(k,1) - r)/r)*100;
disp(['Error estacionario: ',num2str(errest),'%']);

% Determinación de sobreimpulso
posmax = max(pos);
if(posmax > r)
   sobreimpulso = (posmax-r)/r*100;   
   disp(['Sobreimpulso: ',num2str(sobreimpulso),'%']); 
else
   disp('Sobreimpulso 0.00%');     
end

figure(1);
subplot(3,1,1);  plot(t,pos);    ylabel('Posicion');
title('Control sin Acción Integral');
subplot(3,1,2);  plot(t,vel);    ylabel('Velocidad');
subplot(3,1,3);  plot(t,cor);    ylabel('Corriente');
xlabel('Tiempo');   
figure(2);
subplot(2,1,1),   plot(t,volt);  ylabel('Voltaje');
title('Control sin Acción Integral');
subplot(2,1,2);   plot(t,pot);   ylabel('Potencia');
xlabel('Tiempo');   
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
  
% Control con acción integral

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
   
disp(' ');
disp('Control con acción integral');   
q1 = input('Peso q1: ');     % 1.e6   
q2 = input('Peso q2: ');     % 0
q3 = input('Peso q3: ');     % 0
q4 = input('Peso q4: ');     % 1e6
Qi = diag([ q1 q2 q3 q4 ]);  
RRi = 1;
Pi = are(Ai,Bi*inv(RRi)*Bi',Qi);
Ki = inv(RRi)*Bi'*Pi;
ti = 0;    tf = 10;   dt = 0.001;
t = ti:dt:tf;    t = t';
[ Ak Bk ] = c2d(A,B,dt);
[ Ak Wk ] = c2d(A,Wf,dt);
x = [ 0;  0;  0 ];     % Vector de estado inicial

int_err = 0;       % Valor incial de integral del error
k = 1;
for tt = ti:dt:tf
   pos(k,1) = x(1,1);
   vel(k,1) = x(2,1);
   cor(k,1) = x(3,1);
   int_err = int_err + (x(1,1)-r)*dt;
   u = -Ki(1,1:3)*x - Ki(1,4)*int_err;
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

% Determinación de errror estacionario
k = k - 1;
errest = ((pos(k,1) - r)/r)*100;
disp(['Error estacionario: ',num2str(errest),'%']);

% Determinación de sobreimpulso
posmax = max(pos);
if(posmax > r)
   sobreimpulso = (posmax-r)/r*100;   
   disp(['Sobreimpulso: ',num2str(sobreimpulso),'%']);  
else
   disp('Sobreimpulso 0.00%');   
end
disp(' ');

figure(3);
subplot(3,1,1);  plot(t,pos);    ylabel('Posicion');
title('Control con Acción Integral');
subplot(3,1,2);  plot(t,vel);    ylabel('Velocidad');
subplot(3,1,3);  plot(t,cor);    ylabel('Corriente');
xlabel('Tiempo');

figure(4);
subplot(2,1,1),   plot(t,volt);  ylabel('Voltaje');
title('Control con Acción Integral');
subplot(2,1,2);   plot(t,pot);   ylabel('Potencia');
xlabel('Tiempo');   
    
% Diagrama de Bode
Acl = Ai - Bi*Ki;
Bcl = Wri;
Ccl = Ci;
Dcl = Di;
fre = 0:0.1:20;   fre = fre';
wrs = 2*pi*fre;
[ mag fase ] = bode(Acl,Bcl,Ccl,Dcl,1,wrs);
figure(5);
subplot(2,1,1);  loglog(fre,mag);    grid;
subplot(2,1,2);  semilogx(fre,fase);   grid;




    
    


    
    