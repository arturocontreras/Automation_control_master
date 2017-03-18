close all; clc;
load identi.mat
y1=datos1.signals.values(:,2);
u1=datos1.signals.values(:,1);
tt = datos1.time;
%plot(tt,u1,tt,y1)
% u1 = u1*5+50;
% y1 = y1-2.8;

ts=0.5;
Wnl=0;
Wnh= 20;
est_id=iddata(y1,u1,ts);
est_id.InputName='Flujo_agua';
est_id.OutputName='Temperatura';
est_idF=idfilt(est_id,[Wnl Wnh]);
% %200:400
ze=est_idF(200:400);
%idplot(ze(200:300))
ze=dtrend(ze);
%impulse(ze,'sd',k)
impulse(ze,'sd',k,'fill');
m1=pem(ze);
get(m1);
m1.EstimationInfo
%800:903
%700:1000
zv=est_id(700:900);
zv=dtrend(zv);
compare(zv,m1)
figure(5)
bode(m1);
figure(6)
nyquist(m1,'sd',k);
figure(7)
step(m1,ze)

%% Modelos ARX

%m2 = arx(ze,[na nb nk])
V = arxstruc(ze,zv,struc(1:5,1:5,1:5))
%5     5     5
%4 3 10
%1 1 10 24.1%

%Hallando 5 modelos
%2 1 10
%5 2 5
%5 5 4
%4 5 5
%5 4 5
m2 = arx(ze,[2 1 10])
m3 = arx(ze,[1 2 10])
m4 = arx(ze,[2 2 10])
m5 = arx(ze,[1 3 10])
m6 = arx(ze,[1 4 10])

compare(zv,m1,m2,m3,m4,m5,m6)
%Polos y ceros de los modelos
pzmap(m1,m2)
bode(m1,m2)

%% Modelos ARMAX: 5 5 3 5
%2 1 2 10
na = 2;
nb = 1;
nc = 2;
nk = 10;
m7 = armax(ze,[na nb nc nk])
compare(zv,m1,m2,m7)

