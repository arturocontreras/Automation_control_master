% Control of quarter car model, including human vibration
% sensitivity weighting function

clear;
close all;
clc;

m2 = 10;
m1 = 1;
f2 = 1;    w2 = 2*pi*f2;
f1 = 10;   w1 = 2*pi*f1;
k2 = w2*w2*m2;
k1 = w1*w1*m1;
eta2 = 0.5;
c2 = 2*eta2*w2*m2;

a11 = -c2/m2;    a12 = -k2/m2;    a13 = c2/m2;
a31 = c2/m1;     a32 = k2/m1;     a33 = -c2/m1;    a34 = -k1/m1;
b1 = 1/m1;  0;    b3 = -1/m1;
A = [ a11    a12    a13    0
          1        0      -1      0
        a31    a32    a33   a34
          0        0       1      0 ];
B = [ b1;   0;    b3;   0 ];      
W = [ 0;  0;  0;  -1 ];
C = A(1,:);
D = B(1,:);

%% Funcion para el transformar ruido blanco a coloreado
%De la FT : G(s) = Xop(s)/w(s) = 1/2s +1 ; 
% Xopp(t) = -0.5Xop(t) + 0.5*w(t);
% y = C*Xop = Xop
Cr = 1;
Ar = -0.5;
Br = 0.5;
Z14 = zeros(1,4);

%% Uniendo los 2 sistemas
AA = [ A    W*Cr
       Z14    Ar ];
BB = [ B
           0 ];

q1 = input('Peso x2pp: ');   
q2 = input('Peso x21: ');       
q3 = input('Peso x10: ');     
QQ = diag([ 0  q2  0  q3 0]);
R = [ 1 ];
S = diag([q1,0,0,0,0]);
N = AA'*S*BB;
RR = R+BB'*S*BB;
QQ = QQ + AA'*S*AA;
PP = are(AA - BB*inv(RR)*N',BB*inv(RR)*BB', QQ-N*inv(RR)*N');
K = inv(RR)*BB'*PP;

ti = 0;   tf = 5;   dt = 0.001;
t = ti:dt:tf;   t = t';
nt = length(t);
[Ak Bk  ] = c2d(A,B,dt); 
[Ak Wk ] = c2d(A,W,dt);
[Ark  Brk ] = c2d(Ar,Br,dt);
x = [ 0;  0;  0;  0 ];
xp = [0]; %valor inicial
k = 1;
w = randn(nt,1); %ruido blanco


for tt = ti:dt:tf
    xx21(k,1) = x(2,1);
    xx10(k,1) = x(4,1); 
    u = -K*[ x; xp ];
    FF(k,1) = u;
    xx2_2p(k,1) = C*x + D*u; 
    x = Ak*x + Bk*u + Wk*xp;
    xp = Ark*xp + Brk*w(k,1);
    ruido_coloreado(k,1) = xp;
    k = k+1 ;
end
figure(1);
subplot(3,1,1);  plot(t,xx21,'-k',t,xx10,'-r');      legend('x21','x10');       grid;
subplot(3,1,2);  plot(t,xx2_2p,'-k');   legend('Accel x2p');     grid;
subplot(3,1,3);  plot(t,w,'-k',t,ruido_coloreado,'-r');   legend('ruido blanco','coloreado');     grid;

% % Comparación de los espectros
xx2_2p = xx2_2p - mean(xx2_2p);
N = 4096;
fftxx2 = fft(xx2_2p(1:N,1));
absfftxx2 = abs(fftxx2(1:(N/2+1),1));
K = 0:(N/2);
K = K';
wr = 2*pi*K/N;
fHz = wr/(2*pi*dt);
figure(2);
plot(fHz,absfftxx2,'-r');     legend('Accel x2p');       grid;
