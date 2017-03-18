clear all;close all;clc
%Program 6.6 Animation program for bridge using IVP solver
%Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n, steps per point plotted p
%Calls a one-step method such as trapstep.m
%Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)
%function tacoma(inter,ic,n,p,W)

%tacoma_trapecio([0 1000],[0 0 0.001 0],25000,5,80)
%tacoma_rk([0 1000],[0 0 0.001 0],25000,5,80)

%tacoma_rk_omega_amortiguamiento(inter,ic,n,p,W,omega,amorguamiento,ancho)
tacoma_rk_omega_amortiguamiento([0 1000],[0 0 0.000001 0],25000,5,125,2*pi*38/60,0.01)

%tacoma_rk_omega_amortiguamiento_ancho([0 1000],[0 0 0.001 0],25000,5,125,2*pi*38/60,0.03,12)