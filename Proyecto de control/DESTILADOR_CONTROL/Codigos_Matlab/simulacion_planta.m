clear all;close all;clc

Xd_3=0; Xd_2=0; Xd_1=0;
Xb_3=0; Xb_2=0; Xb_1=0;

L_7=0;L_6=0; L_5=0; L_4=0; L_3=0; L_2=0; L_1=0;

V_5=0; V_4=0; V_3=0; V_2=0; V_1=0;

F_8=0; F_7=0; F_6=0; F_5=0; F_4=0; F_3=0; F_2=0; F_1=0;

ti = 0;
dt = 2;
tf = 200;

rxd = 1;
rxb = 0;


F = 0.1;
Kpd = 0.375;
Kid = 0.375/8.29;

Kpb = -0.075;
Kib = -0.075/23.6;

k  = 1;

t = ti:dt:tf;
t = t';
int_err_Xd = 0;
int_err_Xb = 0;

for tt = ti:dt:tf
    
Xd(k,1) = 2.6707*Xd_1 - 2.3773*Xd_2 + 0.7053*Xd_3...
        + 0.744*L_1 -0.6263*L_2 - 0.6583*L_3 + 0.5571*L_4...
        - 0.8789*V_2 + 0.7102*V_3 + 0.7945*V_4 - 0.64995*V_5...
        + 0.4549*F_5 -0.7948*F_6 + 0.3267*F_7 + 0.01804*F_8;
 
Xb(k,1) = 2.5621*Xb_1 - 2.1877*Xb_2 + 0.6225*Xb_3...
        + 0.5786*L_4 - 0.473*L_5 - 0.4749*L_6 + 0.3947*L_7...
        - 1.302*V_2 + 0.9887*V_3 + 1.1224*V_4 - 0.8685*V_5...
        + 0.2177*F_2 + 0.1005*F_3 - 0.6446*F_4 + 0.3413*F_5;

err_Xd = rxd - Xd(k,1);
err_Xb = rxb - Xb(k,1);
int_err_Xd = int_err_Xd + err_Xd*dt;
int_err_Xb = int_err_Xb + err_Xb*dt;

intd(k,1) = int_err_Xd;
intb(k,1) = int_err_Xb;

ed(k,1) = err_Xd;
eb(k,1) = err_Xb;

u_L(k,1) = Kpd*err_Xd + Kid*int_err_Xd;
u_V(k,1) = Kpb*err_Xb + Kib*int_err_Xb;

L_7 = L_6;  
L_6 = L_5; 
L_5 = L_4;
L_4 = L_3;
L_3 = L_2;
L_2 = L_1;
L_1 = u_L(k,1);

V_5 = V_4;
V_4 = V_3;
V_3 = V_2;
V_2 = V_1;
V_1 = u_V(k,1);

F_8 = F_7;
F_7 = F_6;
F_6 = F_5;
F_5 = F_4;
F_4 = F_3;
F_3 = F_2;
F_2 = F_1;
F_1 = F;

Xd_3 = Xd_2;
Xd_2 = Xd_1;
Xd_1 = Xd(k,1);

Xb_3 = Xb_2;
Xb_2 = Xb_1;
Xb_1 = Xb(k,1);
  
k = k + 1;    
end

figure(1)
subplot(2,1,1); plot(t,Xd); title('Xd');
subplot(2,1,2); plot(t,Xb); title('Xb');

figure(2)
subplot(2,1,1); plot(t,u_L); title('L');
subplot(2,1,2); plot(t,u_V); title('V');

% figure(3)
% subplot(2,1,1); plot(t,ed); title('intd');
% subplot(2,1,2); plot(t,eb); title('intb');
