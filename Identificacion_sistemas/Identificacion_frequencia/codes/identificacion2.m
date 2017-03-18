clear all;close all;clc

K = 0.01;
b = 0.1;
J = 0.01;
R = 1;
L=0.5;

stringsPrompt  = {'Filename' , 'flow','fhigh',...
                   'Number of Periods',...
                   'Settling Time','Bias',...
                   'Sample Time','Gain'};
               
defaultAnswer = {'motor_ideal','1','100','10','10','0','0.1','2'};
inputVars = inputdlg(stringsPrompt,'Parameters',1,defaultAnswer);


filename = inputVars{1,1};
flow = str2double(inputVars{2,1});
fhigh = str2double(inputVars{3,1});
NbrOfPeriods = str2double(inputVars{4,1});
SettlingTime = str2double(inputVars{5,1});

Bias = str2double(inputVars{6,1});

if(flow > fhigh)
   disp('Incorrect range');
   return;
end
S = str2double(inputVars{7,1});
U0 = str2double(inputVars{8,1});

omega = (logspace(log10(flow),log10(fhigh),NbrOfPeriods));

id_motor.s = S;
id_motor.bias = Bias;
id_motor.u0 = U0;

EstVec = [];

for k = 1:length(omega)
    
    id_motor.w = omega(k);
    T = 2*pi/id_motor.w;
    
    id_motor.Tstart = (floor(SettlingTime/T)+1)*T;
    id_motor.Tstop = id_motor.Tstart + NbrOfPeriods*T;
    
    set_param(filename, 'SimulationCommand','connect');
    set_param(filename, 'SimulationCommand','start');
    
    pause(10);
    
    s_T = s_T(end);
    c_T = c_T(end);
    EstVec = [EstVec ; id_motor.w 2/(id_motor.u0*NbrOfPeriods)*(s_T +  (1i)*c_T)]
    
    set_param(filename, 'SimulationCommand','stop');
    set_param(filename, 'SimulationCommand','disconnect');
    pause(4);
    
end















