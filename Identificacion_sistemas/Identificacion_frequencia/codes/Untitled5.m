clear all;close all;clc
s=0:10;
% j=sqrt(-1);
% s=1+s*j;
s=s'
k1=866.4*((s+21.5).*(s.^2+s+516.1984))./((s.^2+s+411.6841).*(s+3).*(s-60).^2.*sqrt((s+7.8).*(37.4-s)))

k2=(2.02*(s.^2+625))./((s+7.743).*(s+21.54).*(s+59.94))