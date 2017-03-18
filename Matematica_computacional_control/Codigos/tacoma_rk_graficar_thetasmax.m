clear all;close all;clc
%Algoritmo para encontrar el 
factor_buscado = 100;
v_min = 0.5*10^-3;
%v_min = 50;
v_max = 200;
%function tacoma(inter,ic,n,p,W)
k=1;
for v = v_min:1:v_max
    
    theta = tacoma_rk_entrega_thetamax([0 1000],[0 0 0.000001 0],20000,5,v) %factor de magnificación
    thetas(k) = theta;
    W(k) = v;
    
    disp(v)
    
    k=k+1;
        
end

plot(W,thetas)
