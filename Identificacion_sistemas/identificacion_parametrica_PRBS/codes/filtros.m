yys=spectrum.welch;
y1=datos1.signals.values(:,2);
DEP=psd(yys,y1(200:300))
plot(DEP)