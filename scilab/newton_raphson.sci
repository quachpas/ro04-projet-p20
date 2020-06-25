function [xk, k, iterations, times]=newton_raphson(f, gradf, hessf, x0, epsilon, N)
    // Paramètres de Newton-Raphson

    if ~exists("epsilon") then
        epsilon = input("epsilon ? Press Enter to default to 10^(-10): ")
        if isempty(epsilon) then
            epsilon = 10^(-10)
        end
    end

    if ~exists("N") then
        N = input("N ? Press Enter to default to 10000: ")
        if isempty(N) then
            N = 10000
        end
    end

    xk = x0
    iterations = [x0]
    times = []
    tk = 1
    k = 1
    // Recherche d'un optimum
    while norm(gradf(xk), 2) > epsilon & k < N
        tic()
        dk = - hessf(xk)\gradf(xk)
        tk = line_search(f, gradf, xk, dk, tk, regle, dicho, m1, m2, c)
        xk = xk + tk * dk
        iterations = [iterations, xk]
        times = [times; toc()]
        k = k +1;
    end
endfunction
