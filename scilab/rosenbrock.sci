p = 100

function [r]=rosenbrock(x,y)
    r = p*(x^2-y)^2+(x-1)^2
endfunction

function [gradr]=gradrosenbrock(x,y)
    gradr = [2*(2*p*x^3-2*p*y+x-1) -2*p*(x^2-y)]
endfunction

function [hessr]=hessrosenbrock(x,y)
    hessr = [12*p*x^2-2*p*y+2 -4*p*x; -4*p*x 2*p]
endfunction
