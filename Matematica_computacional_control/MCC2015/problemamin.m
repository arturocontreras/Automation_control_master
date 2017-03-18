clc
x0 = [1;1];
A = []; b = []; Aeq = []; beq = [];
LB = [-5; -5]; UB = [5;5];
[xopt,fopt] = fmincon('fun',x0,A,b,Aeq,beq,LB,UB,'nonlcon')
