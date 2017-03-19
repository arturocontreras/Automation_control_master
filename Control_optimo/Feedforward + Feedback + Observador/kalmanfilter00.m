
%  Determinaci�n de la PDF de una Se�al Gausiana
%  ---------------------------------------------  


clear;
clc;
%casesen on;
close all;
pi = 3.141592;


% Generaci�n de una variable random gausina
% -----------------------------------------
%  Matlab genera una se�al gausiana con
%  valor medio = 0, y desviacion estandard = 1.0 

nx = 5000;                 % N�mero de puntos de la se�al
x = randn(nx,1);           % Generaci�n de la se�al
x = x + 5;

% Una se�al gaussiana se puede generar tambi�n como
% la suma de se�ales unifornes


maxx = max(x);
minx = min(x);
mx = mean(x);


% C�lculo de la pdf a partir de la data 
% -------------------------------------

ndx = 100;                       % N�mero de intervalos
intx = (maxx-minx)/ndx;          % Ancho de cada intervalo
for k = 1:ndx
  m1 = minx + (k-1)*intx;
  m2 = m1 + intx;
  xm(k,1) = (m1+m2)/2;
  pdfx(k,1) = 0;
  for kn = 1:nx   
     if( (x(kn,1)>=m1) & (x(kn,1)<m2) )
       pdfx(k,1) = pdfx(k,1) + 1;
     end
  end
  pdfx(k,1) = (pdfx(k,1)/nx)/intx;
end


% C�lculo de la pdf te�rica
% --------------------------

mx = mean(x);
stdx = std(x);
dx = (maxx-minx)/nx;
xx = minx:dx:maxx;
xx = xx';
aex = ((xx-mx).^2)./(2*stdx^2);
pdfxt = (1/(stdx*sqrt(2*pi))).* exp(-aex);


% Graficando
% ----------

figure(1);
subplot(2,1,1);
plot(x);    grid;
title('Se�al random x');

subplot(2,1,2);
plot(xm,pdfx,xx,pdfxt);   grid;
title('PDF calculada y PDF te�rica');

clc;
disp('   ');
disp('   ');
disp(['Valor medio          = ',num2str(mx)]);
disp(['Desviaci�n estandard = ',num2str(stdx)]);
disp('   ');
disp('   ');





