clear;
close all;
clc;

%  Meta llegar a r = 0.3m en menos de 2 seg.

R = 1.1;
L = 0.0001;
Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.003;
m = 1.00;
c = 40;
r = 0.015;
alfa = 45*pi/180;
d = m + 2*pi*I*tan(alfa)/(p*r);
a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;
A = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
B = [ 0
      0
      b31 ];
Wf = [ 0
       w21       
       0 ];
q1 = input('Peso q1 : ');
q2 = input('Peso q2 : ');
q3 = input('Peso q3 : ');
Q = diag([ q1 q2 q3 ]);
RR = [ 1 ];
P = are(A,B*inv(RR)*B',Q);
K = inv(RR)*B'*P; 

% Análisis de Robustez de Kharitonov
% Variación de Coeficientes:
Ktmin = 0.00001;      Ktmax = 0.0573;     % Reducción en la generación de torque
cmin = 2;       cmax = 40;
alfa1 = 0.1;
alfa2 = 0.2;
Ktt = [ Ktmin
        Ktmin + alfa1*(Ktmax-Ktmin)
        Ktmax ];
cc = [ cmin
       cmin + alfa2*(cmax-cmin)
       cmax ];
k = 1;
for ii = 1:3
Kt = Ktt(ii,1);
for jj = 1:3
c = cc(jj,1);
R = 1.1;
L = 0.0001;
% Kt = 0.0573;
Kb = 0.05665;
I = 4.326e-5;
p = 0.003;
m = 1.00;
% c = 40;
r = 0.015;
alfa = 45*pi/180;
d = m + 2*pi*I*tan(alfa)/(p*r);
a22 = -c/d;
a23 = Kt*tan(alfa)/(r*d);
a32 = -2*pi*Kb/(p*L);
a33 = -R/L;
b31 = 1/L;
w21 = -1/d;
A = [ 0   1   0   
      0  a22 a23 
      0  a32 a33 ];
B = [ 0
      0
      b31 ];
Wf = [ 0
       0 ];
polinomio(k,:) = poly(eig(A-B*K));
k = k + 1;
end
end

disp('-------');
% Armando polinomios de Kharitonov
maxa = max(polinomio);
mina = min(polinomio);
poli1 = [ maxa(1,1) maxa(1,2) mina(1,3) mina(1,4) ]
poli2 = [ mina(1,1) mina(1,2) maxa(1,3) maxa(1,4) ]
poli3 = [ mina(1,1) maxa(1,2) maxa(1,3) mina(1,4) ]
poli4 = [ maxa(1,1) mina(1,2) mina(1,3) maxa(1,4) ]
%clc;
disp(' ');
disp('Raíces de los cuatro polinomios de Kharitonov');
disp('---------------------------------------------');
format short e;
roots(poli1)
roots(poli2)
roots(poli3)
roots(poli4)

