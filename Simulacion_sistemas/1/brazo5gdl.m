%-----------------------------
%Unión de 5 grados de libertad
%-----------------------------
clc; clear all; close all;
%Longitud de brazos
%-------------------
a1 = 7;
a2 = 5;
a3 = 4;
a4 = 3;
a5 = 2;
%Máximo alcance
%--------------
L = abs(a1+a2+a3+a4+a5);

%Angulo final de giro de cada motor
%----------------------------------
af1 = 60;
af2 = -120;
af3 = 90;
af4 = -90;
af5 = 20;

%Parámetros temporales
%---------------------
t1_1 = 0; %Inicia subida motor 1
t1_2 = 3; %Termina subida motor 1
t2_1 = 1;
t2_2 = 2;
t3_1 = 1;
t3_2 = 4;
t4_1 = 0;
t4_2 = 2;
t5_1 = 1;
t5_2 = 3;

tf= 5; %Tiempo final de simulación
N = 500; %Cantidad de puntos
t = linspace(0,tf, N);
%Genera trayectorias
%-------------------
th1 = trapecio(t, t1_1, t1_2, af1);
th2 = trapecio(t, t2_1, t2_2, af2);
th3 = trapecio(t, t3_1, t3_2, af3);
th4 = trapecio(t, t4_1, t4_2, af4);
th5 = trapecio(t, t5_1, t5_2, af5);

for i = 1:N
%Matriz de giro
%--------------
T1 = mat_giro(th1(i), a1);
T2 = T1*mat_giro(th2(i),a2);
T3 = T2*mat_giro(th3(i),a3);
T4 = T3*mat_giro(th4(i),a4);
T5 = T4*mat_giro(th5(i),a5);

%Extrae posiciones
%-----------------
plot(0,0, 'ok', ...
T1(1,4), T1(2,4), 'ob', ...
T2(1,4), T2(2,4), 'or', ...
T3(1,4), T3(2,4), 'oy', ...
T4(1,4), T4(2,4), 'om', ...
T5(1,4), T5(2,4), 'og');

title('Trayectoria brazo 5 GDL')
xlabel('Eje X');
ylabel('Eje Y');
legend('O0', 'O1', 'O2', 'O3', 'O4', 'O5');
axis([-L L -L L]);
line ([0 T1(1,4)],[0 T1(2,4)], 'Color', 'k', 'LineWidth', 2);
line ([T1(1,4) T2(1,4)],[T1(2,4) T2(2,4)], 'Color','b', 'LineWidth', 2);
line ([T2(1,4) T3(1,4)],[T2(2,4) T3(2,4)], 'Color','r', 'LineWidth', 2);
line ([T3(1,4) T4(1,4)],[T3(2,4) T4(2,4)], 'Color','y', 'LineWidth', 2);
line ([T4(1,4) T5(1,4)],[T4(2,4) T5(2,4)], 'Color','m', 'LineWidth', 2);

text(0,0.9*L,strcat(num2str(t(i)),' s'));
drawnow;
end