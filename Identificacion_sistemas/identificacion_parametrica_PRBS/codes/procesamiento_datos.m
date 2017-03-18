%% Datos
t=datos.time;
salida = datos.signals(1,1).values;
u=salida(:,1);
u=u(1500:length(u));

y=datos.signals(1,2).values;
y=y(1500:length(y));

y1=y-min(y);
u1=u-min(u);
planta = iddata(y1,u1,0.01);%0.01 es el tiempo de muestreo

idplot(planta)

%% Identificación
ze = planta(1:(length(y1)/2));%para identificación
ze = dtrend(ze);
zv = planta(length(y1)/2:length(y1));%para validación
zv = dtrend(zv);

m1 = armax(ze,[2 2 2 56]);
compare(zv,m1)

% m1 = arx(ze,[1 2 20]);
% m2 = armax(ze, [1 2 1 10]);
% compare(zv,m1,m2)