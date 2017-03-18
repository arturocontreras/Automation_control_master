clear all;close all;clc
J=0.01;
b=0.1;
K=0.01;
R=1;
L=0.005;
A = [0 1 0; 0 -b/J K/J; 0 -K/L -R/L];
B = [0; 0; 1/L];
C =  [0  1  0];
D = 0; 
motor1 = ss(A,B,C,D);
t = 0:0.001:0.8;

num=K;
den=[(J*L) ((J*R)+(L*b)) ((b*R)+K^2)];
motor2 = tf(num,den)

hold on
figure(1)
step(motor1,t)
step(motor2)
hold off
