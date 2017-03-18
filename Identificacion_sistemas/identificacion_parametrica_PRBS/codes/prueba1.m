%% Analisis 1
z = tf('z',0.5)
format short
%H=(0.0008118*z^-10 - 0.001346*z^-11 + 0.001416*z^-12 + 0.002544*z^-13)/(1 - 0.9535*z^-1)
H = (0.0005721*z^-10)/(1 - 1.9*z^-1 + 0.906*z^-2)
G=d2c(H,'tustin')
t=0:0.5:999999;
t=t(1:length(u1))
lsim(G,u1,t)

%% Metodo2
z = tf('z')
Hz = C*inv(z*eye(2,2)-A)*B+D
eig(A)
disp('A')
A

Hs = d2c(Hz,'zoh')
[A1 B1 C1 D1] = tf2ss(Hs.num{1,1},Hs.den{1,1});
disp('A1')
A1
eig(A1)

pole(Hs)
figure(1)
nyquist(Hs);

t=t(1:length(u1));
figure(2)
lsim(Hs,u1,t);

%% metodo3