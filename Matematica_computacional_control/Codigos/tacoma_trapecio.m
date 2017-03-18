%Program 6.6 Animation program for bridge using IVP solver
%Inputs: time interval inter,
% ic=[y(1,1) y(1,2) y(1,3) y(1,4)],
% number of steps n, steps per point plotted p
%Calls a one-step method such as trapstep.m
%Example usage: tacoma([0 1000],[1 0 0.001 0],25000,5)
function tacoma_trapecio(inter,ic,n,p,w)
clf % clear figure window
h=(inter(2)-inter(1))/n;
y(1,:)=ic; % enter initial conds in y
t(1)=inter(1);len=6;
set(gca,'XLim',[-8 8],'YLim',[-8 8], ...
'XTick',[-8 0 8],'YTick',[-8 0 8], ...
'Drawmode','fast','Visible','on','NextPlot','add');
cla; % clear screen
axis square % make aspect ratio 1-1
road=line('color','b','LineStyle','-','LineWidth',5,...
'erase','xor','xdata',[],'ydata',[]);
lcable=line('color','r','LineStyle','-','LineWidth',1,...
'erase','xor','xdata',[],'ydata',[]);
rcable=line('color','r','LineStyle','-','LineWidth',1,...
'erase','xor','xdata',[],'ydata',[]);
for k=1:n
    for i=1:p
        t(i+1)=t(i)+h;
        y(i+1,:)=trapstep(t(i),y(i,:),h,w);
        yy(5*k+i-5) = y(1,1);
        theta(5*k+i-5) = y(1,3);
        %y(i+1,:)=runge_step(t(i),y(i,:),h,w);
    end
    y(1,:)=y(p+1,:);t(1)=t(p+1);
    z1(k)=y(1,1);z3(k)=y(1,3);
    c=len*cos(y(1,3));s=len*sin(y(1,3));
    
    cota_inf  = length(theta)-50
    if(cota_inf < 1) cota_inf=1; end
    factor = max(theta(cota_inf:length(theta)))/ic(1,3); %el maximo de las 50 ultimas muestras
    
    factor = max(theta)/ic(1,3);%el maximo general para el factor de magnificacion
    
    figure(1)
    set(road,'xdata',[-c c],'ydata',[-s-y(1,1) s-y(1,1)])
    set(lcable,'xdata',[-c -c],'ydata',[-s-y(1,1) 8])
    set(rcable,'xdata',[c c],'ydata',[s-y(1,1) 8])
    drawnow;  
    title(['Metodo trapecio, W=' num2str(w) 'Km/hr, Factor Magnificacion = ' num2str(factor) ])
    %pause(h); 
    pause(0.0001)
   
    figure(2)
    subplot(211)
    plot(yy)
    title('Metodo trapecio : posicion y(t)')
    
    subplot(212)
    plot(theta)
    title(['Metodo trapecio : theta(t) , theta(0) = ' num2str(ic(1,3))])
    
end


function y=trapstep(t,x,h,w)
%one step of the Trapezoid Method
z1=ydot(t,x,w);
g=x+h*z1;
z2=ydot(t+h,g,w);
y=x+h*(z1+z2)/2;


function ydot=ydot(t,y,w)
len=6;a=0.2; W=w; omega=2*pi*38/60;
a1=exp(a*(y(1)-len*sin(y(3))));
a2=exp(a*(y(1)+len*sin(y(3))));
ydot(1)=y(2);
ydot(2)=-0.01*y(2)-0.4*(a1+a2-2)/a+0.2*W*sin(omega*t);
ydot(3)=y(4);
ydot(4)=-0.01*y(4)+1.2*cos(y(3))*(a1-a2)/(len*a);
