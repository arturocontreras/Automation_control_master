%Aplicación de control de nivel con PID
%--------------------------------------
clc; clear all; close all
genera_PID;
pause(0.1);
 
figure;
while (1)
 
    pFile = fopen('C:\Users\ARTURO\Documents\comun\parametros_pid.txt','r'); 
    par_pid2 = fscanf(pFile, '%f');  
    fclose(pFile);
    %Evalúa si se han modificado los parámetros del PID
    if ~isequal(par_pid, par_pid2)
        genera_PID;
    end
    
    pFile = fopen('C:\Users\ARTURO\Documents\comun\informacion.txt','r'); 
    proc_data = fscanf(pFile, '%f');  
    fclose(pFile);
    
    %Si hay información, procede a graficar
    if (~isempty(proc_data))
        tk  = proc_data(1);
        spk = proc_data(2);
        pvk = proc_data(3);
        uk  = proc_data(4);
        subplot(2,1,1);
        plot(tk, spk, '-ob', tk, pvk, '-xr');
        title('Proceso de Nivel');
        xlabel('Tiempo [s]');
        ylabel('Nivel [m]');
        legend('SP', 'PV', 'Location', 'NorthWest');
        hold on
        subplot(2,1,2);
        plot(tk, uk, 'dk');
        title('Señal de control');
        xlabel('Tiempo [s]');
        ylabel('Voltaje [V]');
        hold on
        pause (0.25);
    end
end
