function A = mat_giro(th, a)
A = [cos(th) -sin(th) 0 a*cos(th)
sin(th) cos(th) 0 a*sin(th)
0 0 1 0
0 0 0 1];
end

