clear all;close all;clc
%Algoritmo para encontrar el 
factor_buscado = 100;
v_min = 0.5*10^-3;
%v_min = 50;
v_max = 80;
%function tacoma(inter,ic,n,p,W)
k=1;
for v = v_min:1:v_max
    
    factor = tacoma_rk_entrega_FM([0 1000],[0 0 0.001 0],20000,5,v) %factor de magnificación
    FM(k) = factor;
    W(k) = v;
    disp(v)
    
    if(factor > factor_buscado) %si el factor de magnificacion es mayor
        break                   % que el factor buscado, sale de la busqueda
    end
    
    k=k+1;
        
end

plot(W,FM)
