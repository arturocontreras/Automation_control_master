% Fusion de encoder y acelerometro 
% para estimar la velocidad lineal.
% La señal de acelerómetro se considera 
% como perturbación de la planta.
% La señal de encoder se considera como
% como medición.

clear;
clc;
close all;

% Generando angulo y velocidad reales
ti = 0;  dt = 0.001;    tf = 15;
t = ti:dt:tf;   t = t';
nt = length(t);
fre = 0.5;
fi = 0;
x = 3*sin(2*pi*fre*t + fi);
xvel = 6*pi*fre*cos(2*pi*fre*t + fi);
xacel = -12*pi*pi*fre*fre*sin(2*pi*fre*t + fi);
ruido = randn(nt,1);
ruido = (ruido-mean(ruido))/std(ruido);
xacelruido = xacel + 2*2*ruido;

% Encoder
pulsos = 100;     % 200 pulsos por vuelta
dang = 2*pi/pulsos;

% Determinando angulo medido por encoder
k = 1;
x_old = 0;
for tt = ti:dt:tf
    xk = x(k,1);
    if(xk >= 0)
         x_enc(k,1) = dang*floor(xk/dang);
    elseif(xk < 0)
         x_enc(k,1) = dang*ceil(xk/dang);
    end
    xvel_enc(k,1) = (x_enc(k,1) - x_old)/dt;
    x_old = x_enc(k,1);
    k= k + 1;
end


% Diseñando observador
A = [ 0 1
        0 0 ];
W = [ 0 
         1 ];
C = [ 1 0 ];
% Se asume q = variance de la aceleración
% y se irá probando como un peso.
% Se asume r = variance del encoder
% y se irá probando com un peso;
q = input('Peso q [50]: ');
r = input('Peso r [1]: ');
Q = W*[q]*W';
R = [r];
S = are(A',C'*inv(R)*C,Q);
L = S*C'*inv(R);
Ao = A-L*C;
Wo = W;
Lo = L;
[Aok Wok] = c2d(Ao,Wo,dt);
[Aok Lok] = c2d(Ao,Lo,dt);

y = x_enc;

xh = [ x_enc(1,1); 0 ];
xha = [ x_enc(1,1); 0 ];
k = 1;
acel_int = 0;
for tt = ti:dt:tf
    xxh(k,1) = xh(1,1);
    xxvelh(k,1) = xh(2,1);
    xxha(k,1) = xha(1,1);
    xxvelha(k,1) = xha(2,1);   
    xh = Aok*xh + 0*Wok*xacelruido(k,1) + Lok*y(k,1);
    xha = Aok*xha + 1*Wok*xacelruido(k,1) + Lok*y(k,1);  
  %  acel_int = acel_int + xacelruido(k,1)*dt;
    acel_int = acel_int + xacel(k,1)*dt;   
    vel_acel(k,1) = acel_int;
    k = k + 1;
end
figure(1);
plot(t,x,'-k',t,x_enc,'-g',t,xxh,'-b',t,xxha,'-r');
legend('Black: Actual','Green: Encoder','Blue: Estimacion solo encoder','Red: Estimacion encoder+accel');
title('Posicion');
grid;
figure(2);
plot(t,xvel,'-k',t,xvel_enc,'-g',t,xxvelh,'-b',t,xxvelha,'-r',t,vel_acel,'-y');
legend('Black: Actual','Green: Encoder','Blue: Estimacion solo encoder','Red: Estimacion encoder+accel','Yellow: Integra accel');
title('Velocidad');
grid;



