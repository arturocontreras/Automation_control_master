clear all;
close all;
clc;

Ts = 0.01;
z = tf('z',Ts);

% Discrete system
A = [0 1 0; 0 0 1; 0.41 -1.21 1.8];
B = [0; 0; 0.01];
C = [7 -73 170];
D = 1;

% Set as state space
sys1 = ss(A,B,C,D,Ts);

% Compute transfer function
sys2 = C*inv(z*eye(3) - A)*B + D;

% Compute the actual transfer function
[num,den] = ss2tf(A,B,C,D)
sys3 = tf(num,den,Ts)

% Show bode
bode(sys1,'b',sys2,'r--',sys3,'g--');