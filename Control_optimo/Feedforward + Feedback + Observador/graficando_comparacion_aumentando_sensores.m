clear all;close all;clc
N = [2 3 4];
x1 = [0.12746	0.11451	0.10413]
x2 = [0.28743	0.24036	0.198]

figure(1)
plot(N,x1,'or')
hold on
plot(N,x1,'-r')
plot(N,x2,'ob')
plot(N,x2,'-b')
set(gca,'xtick',0:3)

%grid on
legend('','STD Kalman','','STD Promedio')
ylabel('STD')
xlabel('# sensores')