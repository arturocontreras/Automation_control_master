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

b1h = 50;     boh = 500;
a1h = 50;     aoh = 1200;
Ah = [ -a1h   1
          -aoh   0 ];
Bh = [ b1h;    boh ];      

Z42 = zeros(4,2);
AA = [ A         Z42
          Bh*C    Ah ];
BB = [ B
           Bh*D ];
det([ BB  AA*BB  AA^2*BB  AA^3*BB  AA^4*BB  AA^5*BB ])       

q5 = input('Peso accel-human: ');
q2 = input('Peso x21: ');       
q4 = input('Peso x10: ');     
QQ = diag([ 0  q2  0  q4  q5  0 ]);
RR = [ 1 ];
PP = are(AA,BB*inv(RR)*BB', QQ);
K = inv(RR)*BB'*PP;

ti = 0;   tf = 5;   dt = 0.001;
t = ti:dt:tf;   t = t';
nt = length(t);
xop = randn(nt,1);
[Ak Bk  ] = c2d(A,B,dt); 
[Ak Wk ] = c2d(A,W,dt);
[Ahk  Bhk ] = c2d(Ah,Bh,dt);
x = [ 0;  0;  0;  0 ];
xh = [ 0;  0 ];
k = 1;
xop = randn(nt,1);
for tt = ti:dt:tf
    xx21(k,1) = x(2,1);
    xx10(k,1) = x(4,1); 
    u = -K*[ x; xh ];
    FF(k,1) = u;
    xx2_2p(k,1) = C*x + D*u; 
    x = Ak*x + Bk*u + Wk*xop(k,1);
    xh = Ahk*xh + Bhk*xx2_2p(k,1);
    xx2h(k,1) = xh(1,1);
    k = k+1 ;
end
figure(1);
subplot(2,1,1);  plot(t,xx21,'-r',t,xx10,'-b');      legend('x21','x10');       grid;
subplot(2,1,2);  plot(t,xx2_2p,'-r',t,xx2h,'-b');   legend('Accel x2p','Accel Human');     grid;


% Comparación de los espectros

xx2_2p = xx2_2p - mean(xx2_2p);
xx2h = xx2h - mean(xx2h);

N = 4096;
fftxx2 = fft(xx2_2p(1:N,1));
fftx2h = fft(xx2h(1:N,1));
absfftxx2 = abs(fftxx2(1:(N/2+1),1));
absfftx2h = abs(fftx2h(1:(N/2+1),1));
K = 0:(N/2);
K = K';
wr = 2*pi*K/N;
fHz = wr/(2*pi*dt);
figure(3);
plot(fHz,absfftxx2,'-r',fHz,absfftx2h,'-b');     legend('Accel x2p','Accel Human');       grid;
 