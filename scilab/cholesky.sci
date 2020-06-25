function [L, D, dp]=AlternativeCholesky(A)
    dp = %T
    n = size(A,'r')
    L = eye(n, n)
    d = [d, A(1,1)]
    L(j+1:n,1)=A(j+1:n,1)/d(1)
    v = [] // vecteur intermédiaire l_jk * d_kk
    for j=2:n
        for k=1:j-1
            v(k) = [L(j,k)*d(k)]
        end
        d_coef = A(j,j)-L(j,1:j-1)*v(1:j-1)
        d = [d, d_coef]
        if d_coef <= 0 then
            dp = %F
        end
        L(j+1:n,j)=(A(j+1:n,j)-L(j+1:n,1:j-1)*v(1:j-1))/d(j)
    end
    D = diag(d)
    if dp then
       disp("La matrice est définie positive.") 
    else
        disp("La matrice est définie négative. La factorisation de Cholesky ne fonctionne pas.")
    end
endfunction
