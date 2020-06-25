function [x,k]=newton_raphson(f, gradf, hessf, x0)
    // Paramètres de Newton-Raphson
    epsilon = input("epsilon ? Press Enter to default to 2^(-52): ")
    if isempty(epsilon) then
        epsilon = %eps
    end
    
    N = input("N ? Press Enter to to 1000: ")
    if isempty(N) then
        N = 1000
    end
    
    xk = x0
    tk = 1
    k = 0
    // Recherche d'un optimum
    while norm(gradf(xk), 2) > epsilon & k < N
        dk = - hessf(xk)\gradf(xk)
        tk = line_search(f, gradf, xk, dk, tk)
        xk = xk + tk * dk
        k = k +1;
        disp(k)
    end
endfunction
