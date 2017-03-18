clear all;close all;clc
%% Comparaci�n aproximaci�n serie fourier, a un sistema lineal
%% Planta
num = [45];
den = [1 6 45];
Gs = tf(num,den);

%% Se�ales de entrada exacta y aproximada por Fourier
%Se�al entrada exacta
Amp = 0.5;
f = 1; %Hz
offset = 0.5;
t1 = 0:0.01:10;
u1 = Amp*square(2*pi*f*t1)+offset;
figure(1)
subplot(211)
plot(t1,u1)
axis([0 10 -0.2 1.2])
title('Se�al original square')

%Se�al entrada aproximada por fourier
T = 1;
%ft = 1*(t>=0 & t<0.5)+0*(t>=0.5 & t<1)
syms t x;
a0=(1/T)*int(1,t,0,0.5);
u = a0; %T�rmino 0

for n=1:5 %n�mero de t�rminos de la serie
    an=(2/T)*int(cos(2*pi*n*t/T),t,0,0.5)
    bn=(2/T)*int(sin(2*pi*n*t/T),t,0,0.5)
    
    u = u + an*cos((2*pi/T)*n*x) + bn*sin((2*pi/T)*n*x); %sumando los t�rminos de la serie
end

 x=0:0.01:10; 
 u_x = subs(u,x);
 subplot(212)
 plot(x,u_x)
 title(sprintf('Se�al aproximada por Serie de Fourier %d t�rminos',n));
 
%% Se�ales de salida exacta y aproximada por Fourier

%Se�al de salida exacta y1
y1 = lsim(Gs,u1,t1);
figure(2)
subplot(211)
lsim(Gs,u1,t1)
title('Se�al de salida exacta y1')

%Se�al de salida aproximada y2
y2 = lsim(Gs,u_x,x);
subplot(212)
lsim(Gs,u_x,x)
title('Se�al de salida aproximada y2')

%Se�al de entrada separadas en dominio de la frecuencia 
syms s;
Gsf = 45/(s^2+6*s+45);
ut0 = 1/(2*s);         %t�rmino 0
ut1 = 4/(s^2+4*pi^2);  %primer t�rmino
ut2 = 0;               %segundo t�rmino
ut3 = 4/(s^2+36*pi^2); %tercer t�rmino
ut4 = 0;               %cuarto t�rmino
ut5 = 4/(s^2+100*pi^2);%quinto t�rmino

%Se�ales de salida de cada t�rmino 
yt0=Gsf*ut0;
y0_tiempo = ilaplace(yt0);
y0_tiempo=subs(y0_tiempo,t1) 

yt1=Gsf*ut1;
y1_tiempo = ilaplace(yt1);
y1_tiempo=subs(y1_tiempo,t1) 

yt2=Gsf*ut2;
y2_tiempo = ilaplace(yt2);
y2_tiempo=subs(y2_tiempo,t1) 

yt3=Gsf*ut3;
y3_tiempo = ilaplace(yt3);
y3_tiempo=subs(y3_tiempo,t1) 

yt4=Gsf*ut4;
y4_tiempo = ilaplace(yt4);
y4_tiempo=subs(y4_tiempo,t1) 

yt5=Gsf*ut5;
y5_tiempo = ilaplace(yt5);
y5_tiempo=subs(y5_tiempo,t1) 

y_total = y0_tiempo + y1_tiempo + y2_tiempo + y3_tiempo + y4_tiempo + y5_tiempo;
figure(3)
plot(t1,y_total)
title('C�lculo de la salida sumando la salida de cada t�rmino por separado')



