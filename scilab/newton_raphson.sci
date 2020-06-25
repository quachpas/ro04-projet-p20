function [x]=newton_raphson(f, gradf, hessf, x0)
    // Paramètres de Newton-Raphson
    epsilon = input("epsilon ? Press Enter to default to 2^(-52): ")
    if isempty(epsilon) then
        epsilon = %eps
    end
    disp("epsilon = " + string(epsilon))
    N = input("N ? Press Enter to to 1000: ")
    if isempty(N) then
        N = 1000
    end
    disp("m2 = " + string(N))
    tk = line_search(f, gradf, xk, dk, tk)
    //
endfunction
