%%%%%% MODEL FOLLOW CONTROL CON ACCION INTEGRAL %%%%%%%%%

clear; clc; close all;      %Cerramos y borramos variables para evitar problmodelfollow3emas
%%
% MODELO DE REFERENCIA:  SKY-HOOK DAMPER
%Par�metros del modelo
eta = 0.90;
f = 1.5*0.4;   % Cambiar factor para hacer m�s r�pida
               % la respuesta del sistema controlado (Probar con 1 - 1.5)
w = 2*pi*f;

%% Matrices del sistema
Am = [   0      1
       -w*w    -2*eta*w ];
Bm = [   0
        w*w ];
Cm = [ 1  0 ];

%% Tiempo para simulaci�n
dt = 0.001; ti = 0;  tf = 10;  %Intervalo de tiempo, tiempo inicial y final
t = ti:dt:tf;                  %Tiempo en vector fila
t = t';                        %Tiempo en vector columna
nt = length(t);                %Tama�o del vector tiempo
rast = 0.3*ones(nt,1);         %valor de referencia que queremos alcanzar
[Amk,Bmk] = c2d(Am,Bm,dt);     %discretizamos el sistema

%%
% SISTEMA A CONTROLAR: MOTOR CON TORNILLO SINFIN

%Par�metros del modelo
R = 1.1;                    
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.0075;
m = 0.5*1.00;
c = 10;                     %Fricci�n viscosa aparece dentro del modelo
r = 0.015;
alfa = 45*pi/180;
d = m + 2*pi*I*tan(alfa)/(p*r);
%% Matrices
a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;
A = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];         %Matriz A
B = [ 0
      0
      b31 ];                %Matriz B
Wf = [ 0
       w21       
       0 ];                 %Fricci�n seca act�a como una perturbaci�n no lineal
C = [ 1  0  0 ];   

%% 
disp(' ');
disp('Control Feedbak + Feedforward con acci�n integral');
disp(' ');

q = input('Peso del error [y-ym]   [1e9]: ');     % 4e8
Q = [ q ];                      %Peso �nico
RR = [ 1 ];
%% Hallamos Kx
QQ = C'*Q*C;                    % CTqC para Riccati
P11 = are(A,B*inv(RR)*B',QQ);   %Hallamos P11 para Kx
Kfb = inv(RR)*B'*P11;           %Hallamos Kx

%% Hallamos Kz
APR = A'-P11*B*inv(RR)*B';      %Para Lyapunov
CQCm = -C'*Q*Cm;                % -CTqCb para Lyapunov
P12 = lyap(APR,Am,CQCm);        %Hallamos P12 para Kz
Kff = inv(RR)*B'*P12;           %Hallamos Kz

%% Restricciones
umax = 24;                      %se�al de control m�xima (voltaje)
Pot = 200;                      %Potencia m�xima que soporta el motor
Fric = 1*10;                    %Fricci�n seca externa

%% Discretizamos el sistema
[Ak Bk] = c2d(A,B,dt);          %discretizamos el sistema a controlar
[Ak Wk] = c2d(A,Wf,dt);         

%% Condiciones iniciales
x = [ 0;  0;  0 ];              %Valor inicial de las variables de control
xm = [ 0;  0 ];                 %Valor inicial de las variables del modelo
k = 1;                          %Inicializa la interaci�n

%% Iteramos para hallar u y X y Z
for tt = ti:dt:tf               %Tiempo de la simulaci�n
    xm1(k,1) = xm(1,1);         %Variable del modelo
    xm2(k,1) = xm(2,1);         %Variable del modelo
    x1(k,1) = x(1,1);           %Variable del sistema
    x2(k,1) = x(2,1);           %Variable del sistema
    x3(k,1) = x(3,1);           %Variable del sistema
    time(k,1) = tt;             %Tiempo para graficar
    u = -Kfb*x - Kff*xm;        %  q = 1e8 se�al de control feedback + feedforward
%    if(tt > 5)                 % Analizar efecto cuando se corta voltaje 
%        u = 0;
%    end
    if(u > umax)                %Limitamos la se�al de control (voltaje)
       u = umax;
    elseif(u < -umax)
       u = -umax;
    end
    if(x(2,1) >= 0)             %Si la velocidad es positiva la friccion es positiva
        F = Fric;
    elseif(x(2,1) < 0)          %Si la velocidad es negativa la friccion sera negativa
        F = -Fric;
    end
    uc(k,1) = u;                %Para graficar la se�al de control
    pot(k,1) = u*x(3,1);        %Para graficar la potencia
    x = Ak*x + Bk*u + Wk*F;     %Calculamos X
    xm = Amk*xm + Bmk*rast(k,1);%Calculamos Z
    k = k + 1;                  %Aumentamos la interaci�n
end
            
%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  Con accion integral

%sistema aumentado
Ai = [ 0   1   0  0  
       0  a22 a23 0
       0  a32 a33 0
       1   0   0  0 ];         %Matriz Ai
Bi = [ 0
       0
      b31 
       0 ];                   %Matriz Bi
Wfi = [ 0
        0       
        0 
       -1];                   %Fricci�n seca act�a como una perturbaci�n no lineal
Ci = [ 1  0  0  0];
Di = [0];
Q  = [q];
qi = input('Peso del integrador   [1e9]: ');
Qi  = [0 0 0 0
       0 0 0 0
       0 0 0 0
       0 0 0 qi];                      
RRi = [1];
%% Hallamos Kx
QQi = Ci'*Q*Ci+Qi;                  % CTqC para Riccati
P11i = are(Ai,Bi*inv(RRi)*Bi',QQi); %Hallamos P11 para Kx
Kfbi = inv(RRi)*Bi'*P11i;           %Hallamos Kx

%% Hallamos Kz
APRi = Ai'-P11i*Bi*inv(RR)*Bi';    %Para Lyapunov
CQCmi = -Ci'*Q*Cm;                 % -CTqCb para Lyapunov
P12i = lyap(APRi,Am,CQCmi);        %Hallamos P12 para Kz
Kffi = inv(RR)*Bi'*P12i;           %Hallamos Kz
    
%% Condiciones iniciales
xi = [ 0;  0;  0];              %Valor inicial de las variables de control
xmi = [ 0;  0 ];                 %Valor inicial de las variables del modelo
k = 1;                           %Inicializa la interaci�n
int_err = 0;                     % Valor incial de integral del error
%% Iteramos para hallar u y X y Z
for tt = ti:dt:tf                 %Tiempo de la simulaci�n
    xm1i(k,1) = xmi(1,1);         %Variable posicion del modelo
    xm2i(k,1) = xmi(2,1);         %Variable del modelo
    x1i(k,1) = xi(1,1);           %Variable posicion del sistema
    x2i(k,1) = xi(2,1);           %Variable velocidad del sistema
    x3i(k,1) = xi(3,1);           %Variable corriente del sistema
    int_err = int_err + (xi(1,1)-rast(k,1))*dt; %error de acumulacion
    time(k,1) = tt;               %Tiempo para graficar
    ui = -Kfbi(1,1:3)*xi -Kfbi(1,4)*int_err - Kffi*xmi;  %se�al de control feedback + feedforward
                                                         %con integrador
%    if(tt > 5)                   % Analizar efecto cuando se corta voltaje 
%        u = 0;
%    end
    if(ui > umax)                  %Limitamos la se�al de control (voltaje)
       ui = umax;
    elseif(ui < -umax)
       ui = -umax;
    end
    if(xi(2,1) >= 0)             %Si la velocidad es positiva la friccion es positiva
        F = Fric;
    elseif(xi(2,1) < 0)          %Si la velocidad es negativa la friccion sera negativa
        F = -Fric;
    end
    uci(k,1) = ui;                %Para graficar la se�al de control
    poti(k,1) = ui*xi(3,1);       %Para graficar la potencia
    xi = Ak*xi + Bk*ui + Wk*F;    %Calculamos X
    xmi = Amk*xmi + Bmk*rast(k,1);%Calculamos Z
    k = k + 1;                    %Aumentamos la interaci�n
end
%% Grafimos las respuestas
figure(1);                                    %Graficamos la posici�n
plot(time,xm1,'--r',time,x1,'--b',time,x1i,'k');
legend('modelo',' Fb+Fff ','Fb+Fff+Acc.Integral')
title('Posicion x1'); grid;

figure(2);
subplot(2,1,1);
plot(time,uc,'-b',time,uci,'k');               %Graficamos el voltaje
legend('voltaje Fb+Fff','voltaje Fb+Fff+Acc.Integral');
title('Voltaje'); grid;

subplot(2,1,2);
plot(time,pot,'-b',time,poti,'k');              %Graficamos la potencia
legend('potencia Fb+Fff','potencia Fb+Fff+Acc.Integral');
title('Potencia'); grid;