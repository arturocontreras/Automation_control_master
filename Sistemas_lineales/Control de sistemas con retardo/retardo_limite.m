close all;
b0 = 2; b1 = 1;
a0 = 9; a1 = 5; a2 = 3; a3 = 1;
numG = [ b1 b0 ];
denG = [ a3 a2 a1 a0 ];
Kp = 0.1;
Ki = 0.9;

tau = input('tau: ');

dt = 0.001;
ntau = round(tau/dt);
if(ntau == 0)     % Se da un punto adicional para el caso en que tau = 0. 
    ntau = 1;
end
yy = zeros(ntau,1);
y = 0;    yp = 0; y2p=0; up=0; y3p=0; ua=0;
ti = 0;   tff = 50;
tt = ti:dt:tff;     tt = tt';
nt = length(tt);
r = 0.5*ones(nt,1);
interr = 0;
k = 1;

for t = ti:dt:tff
    ytau = yy(k,1);
    err = r(k,1) - ytau;
    interr = interr + err*dt;
    u = Kp*err + Ki*interr;
    up  = (u - ua)/dt;      %up(k)
    ua=u; %u(k-1)
    y3p=(up*b1+u*b0-a2*y2p-a1*yp-a0*y)/a3; %y3p(k)
    y   =   y  + yp*dt;     %y(k)
    yp  =  yp  + y2p*dt;    %yp(k)
    y2p =  y2p + y3p*dt;    %y2p(k)

    yy(ntau+k,1) = y;
    k = k + 1;
end
yout = yy(ntau:nt+ntau-1,1);


figure
plot(tt,yout);    grid;
title('Salida con retardo. Control PI');
axis([0,30,0,0.9]);


%w = -30:0.07:30;   w = w';
w = 0.005:0.005:200;   w = w';
j = sqrt(-1);
s = j*w;
GN = (Kp+Ki./s).*((b1.*s+b0)./(a3.*s.*s.*s + a2*s.*s + a1*s + a0)).*exp(-s*tau);
GNreal = real(GN);
GNimag = imag(GN);
figure;
plot(GNreal,GNimag);    grid;
title('Diagrama de Nyquist PI con retardo');

