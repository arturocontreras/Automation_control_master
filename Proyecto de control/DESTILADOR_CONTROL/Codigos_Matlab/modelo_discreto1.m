clearvars -except Lsim Vsim Fsim t; clc; close;
%% modelo 
s =tf('s');
A11 = 12.8*exp(-s)/(16.7*s+1);
A12 = -18.9*exp(-3*s)/(21*s+1);
A21 = 6.6*exp(-7*s)/(10.9*s+1);
A22 = -19.4*exp(-3*s)/(14.4*s+1);

B1 = 3.8*exp(-8.1*s)/(14.9*s+1);
B2 = 4.9*exp(-3.4*s)/(13.2*s+1);

A = [A11 A12
     A21 A22];

B = [B1
     B2];
 
%% Simulacion
Tm = 2;
A11k = c2d(A11,Tm,'zoh');
A12k = c2d(A12,Tm,'zoh');
A21k = c2d(A21,Tm,'zoh');
A22k = c2d(A22,Tm,'zoh');
 
B1k = c2d(B1,Tm,'zoh');
B2k = c2d(B2,Tm,'zoh');
 
[numz denz] = tfdata(A11k,'v');
MA11 = idpoly(denz, numz,'Ts', Tm);
 
[numz denz] = tfdata(A12k,'v');
MA12 = idpoly(denz, numz,'Ts', Tm); 

[numz denz] = tfdata(A21k,'v');
MA21 = idpoly(denz, numz,'Ts', Tm); 

[numz denz] = tfdata(A22k,'v');
MA22 = idpoly(denz, numz,'Ts', Tm); 

[numz denz] = tfdata(B1k,'v');
MB1 = idpoly(denz, numz,'Ts', Tm); 

[numz denz] = tfdata(B2k,'v');
MB2 = idpoly(denz, numz,'Ts', Tm); 
 

ti = 0;
dt = Tm;
tf = 200;

Xd_3=0; Xd_2=0; Xd_1=0;
Xb_3=0; Xb_2=0; Xb_1=0;

L_7=0;L_6=0; L_5=0; L_4=0; L_3=0; L_2=0; L_1=0;

V_5=0; V_4=0; V_3=0; V_2=0; V_1=0;

F_8=0; F_7=0; F_6=0; F_5=0; F_4=0; F_3=0; F_2=0; F_1=0;

L = Lsim(:,2);
V = Vsim(:,2);
F = Fsim(:,2);
k  = 1;

t=ti:0.001:(tf+3*0.001); t=t';

for tt = ti:0.001:(tf+3*0.001)
Xd(k,1) = 2.6707*Xd_1 - 2.3773*Xd_2 + 0.7053*Xd_3...
        + 0.744*L_1 - -0.6263*L_2 - 0.6583*L_3 + 0.5571*L_4...
        - 0.8789*V_2 + 0.7102*V_3 + 0.7945*V_4 - 0.64995*V_5...
        + 0.4549*F_5 -0.7948*F_6 + 0.3267*F_7 + 0.01804*F_8;
 
Xb(k,1) = 2.5621*Xb_1 - 2.1877*Xb_2 + 0.6225*Xb_3...
        + 0.5786*L_4 - 0.473*L_5 - 0.4749*L_6 + 0.3947*L_7...
        - 1.302*V_2 + 0.9887*V_3 + 1.1224*V_4 - 0.8685*V_5...
        + 0.2177*F_2 + 0.1005*F_3 - 0.6446*F_4 + 0.3413*F_5;

Lk7(k,1) = L_7;
L_7 = L_6;  
L_6 = L_5; 
L_5 = L_4;
L_4 = L_3;
L_3 = L_2;
L_2 = L_1;
L_1 = L(k,1);

V_5 = V_4;
V_4 = V_3;
V_3 = V_2;
V_2 = V_1;
V_1 = V(k,1);

F_8 = F_7;
F_7 = F_6;
F_6 = F_5;
F_5 = F_4;
F_4 = F_3;
F_3 = F_2;
F_2 = F_1;
F_1 = F(k,1);

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
subplot(2,1,1); plot(t,L); title('L');
subplot(2,1,2); plot(t,V); title('V');
