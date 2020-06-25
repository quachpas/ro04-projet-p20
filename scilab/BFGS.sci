function [xk, k, iterations, times, reset_counter]=BFGS(f, gradf, x0, H0, epsilon, N)
    // Paramètres
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

    // Initialisation
    xk = x0
    Hk = H0
    iterations = [x0]
    times = []
    tk = 1
    k = 1
    reset_counter = 0
    
    // Recherche d'un optimum
    while norm(gradf(xk), 2) > epsilon & k < N
        tic()
        dk = -Hk*gradf(xk)
        tk = line_search(f, gradf, xk, dk, tk, regle, dicho, m1, m2, c)
        sk = tk*dk
        xknext = xk + sk
        iterations = [iterations, xknext]
        yk = gradf(xknext)-gradf(xk)
        lambda = sk'*yk
        M = yk*sk'/lambda
        Hk = (eye()-M)*Hk*(eye()-M')+yk*yk'/lambda
        [L, D, dp] = AlternativeCholesky(Hk)
        if dp == %F then
            Hk = eye()
            reset_counter = reset_counter + 1
        end
        k = k + 1
        xk = xknext
        times = [times; toc()]
    end
endfunction
