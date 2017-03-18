
%Estados:
%x1 = h(t), x2 = th(t), x3 = dhdt(t)
A = [-1 1/50 0; 0 0 1; 0 0 -70.6/6];
B = [0; 0; 25000/3];
C = eye(3);
D = 0; 
nivel_c = ss(A,B,C,D);

Tm = -1/min(pole(nivel_c))/10;
Tm = floor(1000*Tm)/1000;
nivel_d = c2d (nivel_c, Tm, 'zoh');

M = idss(nivel_d.a, nivel_d.b, nivel_d.c, nivel_d.d, ...
    'NoiseVariance', zeros(3), 'Ts', Tm)