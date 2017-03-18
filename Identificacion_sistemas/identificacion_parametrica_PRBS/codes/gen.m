%% Limited band
clear n A up k P
close all
n = 7;
P = 10;
A = [1 0 0 0 0 0 1]; % a6 a5 ... a1
up(1:(n+1)*P,1) = [zeros(n*P,1); ones(P,1)];

for k=n+2:2^n-1
    up((k-1)*P+1:k*P,1) = rem(A(1)*up((k-1)*P,1)+A(2)*up((k-2)*P,1)+A(3)*up((k-3)*P,1)...
        +A(4)*up((k-4)*P,1)+A(5)*up((k-5)*P,1)+A(6)*up((k-6)*P,1)+A(7)*up((k-7)*P,1)+1,2);
end
up = 5*up + 10;
figure(5)

t = (0:0.5:0.5*(length(up)-1))';
plot(t,up)
uprbs = [t up];
axis tight
% uk2 = idinput(12700,'prbs',[0 0.01],[65 85]);
