% Control LQR de motor con tornillo sinfin con y sin accion integral

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
  
% Control con acción integral

Ai = [ 0    1    0     0 
         0  a22 a23  0
         0  a32 a33  0
         1    0    0    0 ]; 
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
q1 = input('Peso q1 - x       [1e6] : ');     % 1.e6   
q2 = input('Peso q2 - xp     [0]     : ');     % 0
q3 = input('Peso q3 - i        [0]     : ');     % 0
q4 = input('Peso q4 - interr [1e6] : ');     % 1e6
q5 = input('Peso q5 - pot [3.3]: ');     

Qi = diag([ q1 q2 q3 q4 ]);  
RRi = 1;
%Matriz de peso de la potencia
N = [0 0 q5 0]';
Pi = are(Ai-Bi*inv(RRi)*N',Bi*inv(RRi)*Bi',Qi-N*inv(RRi)*N');
Ki = inv(RRi)*(Bi'*Pi+N');

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

figure(1);
subplot(3,1,1);  plot(t,pos);    ylabel('Posicion');grid;
title('Control con Acción Integral');
subplot(3,1,2);  plot(t,vel);    ylabel('Velocidad');grid;
subplot(3,1,3);  plot(t,cor);    ylabel('Corriente');grid;
xlabel('Tiempo');

figure(2);
subplot(2,1,1),   plot(t,volt);  ylabel('Voltaje');grid;
title('Control con Acción Integral');
subplot(2,1,2);   plot(t,pot);   ylabel('Potencia');grid;
xlabel('Tiempo');   

    




    
    


    
    