%---------------------------------------
%Genera ecuación de diferencias para PID
%---------------------------------------

%Abre archivo con parámetros de PID:
%-----------------------------------
%Carpeta común
pFile = fopen('C:\Users\ARTURO\Documents\comun\parametros_pid.txt','r'); 
par_pid = fscanf(pFile, '%f');  
fclose(pFile);
%Asigna parámetros:
%------------------
Kp = par_pid(1);
Ti = par_pid(2);
Td = par_pid(3);
N  = par_pid(4);
Tm = par_pid(5);

%Define F.T.: 
%------------
s = tf('s');
PIDs = Kp*(1+1/Ti/s)*(1+Td*s/(1+Td*s/N));
PIDz = c2d(PIDs, Tm, 'tustin');
%Ecuación en diferencias:
%------------------------
[numz denz] = tfdata(PIDz, 'v');
M = idpoly(denz, numz,'NoiseVariance',0, 'Ts', Tm);

%Almacena información:
%---------------------
pFile = fopen('C:\Users\ARTURO\Documents\comun\A_funz.txt','w'); 
fprintf(pFile,'%6.2f\r\n', M.a);  
fclose(pFile);   

pFile = fopen('C:\Users\ARTURO\Documents\comun\B_funz.txt','w'); 
fprintf(pFile,'%6.2f\r\n', M.b);  
fclose(pFile); 
