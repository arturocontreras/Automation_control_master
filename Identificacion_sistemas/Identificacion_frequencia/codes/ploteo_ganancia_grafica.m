w = EstVec(:,1)
g = EstVec(:,2)
figure(1)
subplot(211)
semilogx(w,20*log10(abs(g)))
title('Ganancia')
subplot(212)
semilogx(w, 180/pi*atan2(imag(g),real(g)))
title('Fase')
ang=[];

for k = 1:length(g)
    angulo = 180/pi*atan2(imag(g(k)),real(g(k)));
    %if angulo>0 & k>1
    if k == 7
        angulo = angulo -180;
    elseif k > 9
        angulo = angulo -180;
    end
    ang(k)=angulo;
end
figure(2)
semilogx(w,ang')
