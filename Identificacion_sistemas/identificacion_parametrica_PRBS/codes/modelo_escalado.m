clc;
close all;

t=0:0.5:100000;
t=t(1:length(u1));
temp_init = 40;
%u_esc = u1*5+50;
u_esc = u1;

figure(1)
% lsim(sys_dis,u1,t,'b');
subplot(211)
%lsim(sys_con,u_esc,t);
plot(t,u1,t,y1,'-g')
title('Variación de la temperatura')
legend('u Valvula PRBS' , 'y Variacion temperatura')
subplot(212)
hold on
y_esc=lsim(sys_con,u1,t)
plot(t,y_esc+temp_init,'-b')
y_m1 = lsim(m1,u_esc,t)
plot(t,u1,t,y_m1+temp_init,'k')
plot(t,u1,t,y1+temp_init,'-g')
grid on
axis([0 100 38 42])
title('Valor de la temperatura, con To = 40°C')

figure(2)
step(15*m1)
