clear all;close all;clc
dt =0.001;
ti = 0;
tf = 2;
t = ti:dt:tf;
t = t';
nt =length(t);

%% Figura a maquinar
dt = 0.01;
%Tramo A
velx = 1;
X = [0 15]
Y = [0 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r1x = rx';
r1y = ry';

%Tramo B
velx = 1;
X = [15 10]
Y = [5 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r2x = rx';
r2y = ry';

%Tramo C
velx = 1;
X = [10 5]
Y = [15 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r3x = rx';
r3y = ry';

%Tramo D
vely = 1;
X = [5 5]
Y = [15 10]
t = (abs(Y(2)-Y(1)))/vely;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r4x = rx';
r4y = ry';

%Tramo E
velx = 1;
X = [5 0]
Y = [10 15]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r5x = rx';
r5y = ry';

%Tramo F
velx = 1;
X = [0 5]
Y = [15 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r6x = rx';
r6y = ry';

%Tramo G
velx = 1;
X = [0 5]
Y = [15 5]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r7x = rx';
r7y = ry';

%Tramo H
velx = 1;
X = [5 0]
Y = [5 0]
t = (abs(X(2)-X(1)))/velx;
N = t/dt;
rx = linspace(X(1),X(2),N);
ry = linspace(Y(1),Y(2),N);
r7x = rx';
r7y = ry';

XX = [r1x;r2x;r3x;r4x;r5x;r6x;r7x];
YY = [r1y;r2y;r3y;r4y;r5y;r6y;r7y];

tiempo = length(XX)*dt
plot(XX,YY)

