clc;
close all;

t=0:0.5:100000;
t=t(1:length(u1));
temp_init = 50;
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
y_m7=lsim(m7,u_esc,t)
plot(t,y_m7+temp_init,'-b')
legend('Resultado ARMAX')

y_m2 = lsim(m2,u_esc,t)
plot(t,y_m2+temp_init,'k')
legend('ARX')

plot(t,y1+temp_init,'-g')
legend('Resultado ARMAX','ARX','Valor experimental')


grid on
axis([0 600 48 52])
title('Valor de la temperatura, con To = 50°C')

