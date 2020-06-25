function [xk,k,iterations]=newton_raphson(f, gradf, hessf, x0)
    // Paramètres de Newton-Raphson
    epsilon = input("epsilon ? Press Enter to default to 10^(-10): ")
    if isempty(epsilon) then
        epsilon = 10^(-10)
    end

    N = input("N ? Press Enter to default to 10000: ")
    if isempty(N) then
        N = 10000
    end

    xk = x0
    iterations = [x0]
    tk = 1
    k = 1
    // Recherche d'un optimum
    [regle, dicho, m1, m2, c]=line_search_parameters()
    while norm(gradf(xk), 2) > epsilon & k < N
        dk = - hessf(xk)\gradf(xk)
        tk = line_search(f, gradf, xk, dk, tk, regle, dicho, m1, m2, c)
        xk = xk + tk * dk
        iterations = [iterations, xk]
        k = k +1;
    end
endfunction
