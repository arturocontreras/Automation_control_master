clear all
close all
clc
m1=input('Factor de magnificacion= ');
in=input('Condiciones inicial= ');
mag=m1*in(1,3);
l=6; m=2500; a=0.2;K=1000;
omega=2*pi*38/60;
dt=0.04;
ti=0;tf=1000;
t=ti:dt:tf;
n=500;
k=1;
y=in(1,1);
    y_init=y;
yp=in(1,2);
    yp_init=yp;
th=in(1,3);
    th_init=th;
th_p=in(1,4);
    th_p_init=th_p;
for j=0.5:0.5:80
    k=1;
    yg=zeros(length(t),1);
    thg=zeros(length(t),1);
    y=y_init;
    yp=yp_init;
    th=th_init;
    th_p=th_p_init;
    
for i=ti:dt:tf   
   %tr=t(k,1);
a1=exp(a*(y-l*sin(th)));
a2=exp(a*(y+l*sin(th)));
ypp=-0.01*yp-K/(m*a)*(a1+a2-2)+0.2*j*sin(omega*i);
th_pp=-0.01*th_p+(3*cos(th)*K)/(l*m*a)*(a1-a2);

yp=yp+dt*ypp;
y=y+dt*yp;
yg(k,1)=y;

th_p=th_p+dt*th_pp;
th=th+dt*th_p;
thg(k,1)=th;
k=k+1;
end
if (max(thg)>=m1*th_init)
    maximo_valor=j
 break   
end
end


