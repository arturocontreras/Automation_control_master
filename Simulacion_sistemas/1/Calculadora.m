classdef Calculadora < handle
 properties
    resAns;
    operAns;
 end
 methods
    function obj= Calculadora()
    end
    function s = suma(obj,a,b)
    s = a + b;
    resulAns= s;
    end
 end
end

