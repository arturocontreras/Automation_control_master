% Observador aplicado a señal de encoder
% para estimar la velocidad lineal.

clear;
clc;
close all;

% Generando angulo y velocidad reales
ti = 0;  dt = 0.01;    tf = 15;
t = ti:dt:tf;   t = t';
fre = 0.2;
fi = 1*pi/6;
x = 3*sin(2*pi*fre*t +  fi);
xvel = 6*pi*fre*cos(2*pi*fre*t + fi);

% Encoder
pulsos = 200;     % 20 pulsos por vuelta
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
C = [ 1 0 ];
q1o = input('q1o [100]  : ');
q2o = input('q2o [5000]: ');
Q = diag([ q1o q2o ]);
S = are(A',C'*C,Q);
L = S*C';
Ao = A-L*C;
Lo = L;
[Aok Lok] = c2d(Ao,Lo,dt);
y = x_enc;

xh = [ x_enc(1,1); 0 ];
k = 1;
for tt = ti:dt:tf
    xxh(k,1) = xh(1,1);
    xxvelh(k,1) = xh(2,1);
    xh = Aok*xh + Lok*y(k,1);
    k = k + 1;
end
figure(1);
plot(t,x,'-k',t,x_enc,'-g',t,xxh,'-b');
legend('Posición real','Posición encoder','Posición observada');
figure(2);
plot(t,xvel,'-k',t,xvel_enc,'-g',t,xxvelh,'-b');
legend('Velocidad real','Velocidad encoder','Velocidad observada');



