%Calculo de matrices de covarianzas

clear;
clc
close all;

N = 1000;
w1mean = 2;
w1std = 3;
w1 = randn(N,1);
w1 = (w1 - mean(w1))*w1std/std(w1) + w1mean;
varw1 = (w1 - w1mean)'*(w1 - w1mean)/(N-1)
var(w1)
stdw1 = sqrt(varw1)
std(w1)

w2mean = 1;
w2std = 4;
w2 = randn(N,1);
w2 = (w2 - mean(w2))*w2std/std(w2) + w2mean;

q11 = (w1 - w1mean)'*(w1 - w1mean)/(N-1);
q22 = (w2 - w2mean)'*(w2 - w2mean)/(N-1);
q12 = (w1 - w1mean)'*(w2 - w2mean)/(N-1);
q21 = (w2 - w2mean)'*(w1 - w1mean)/(N-1);
Q = [ q11   q12
         q21   q22 ];
     
w = [ w1  w2 ];
Qc = cov(w);
[ Q Qc ]

