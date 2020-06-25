function [L, D, dp]=AlternativeCholesky(A)
    n = size(A,'r')
    L = eye(n, n)
    d = [d, A(j,j)]
    L(j+1:n,j)=A(j+1:n,j)/d(j)
    v = [] // vecteur intermédiaire l_jk * d_kk
    disp(d,L,v)
    for j=2:n
        for k=1:j-1
            v = [v; L(j,k)*A(k,k)]
        end
        d = [d, A(j,j)-L(j,1:j-1)*v(1:j-1)]
        if d == 0 then
            dp = %F
        end
        L(j+1:n,j)=(A(j+1:n,j)-L(j+1:n,1:j-1)*v(1:j-1))/d(j)
    end
    D = diag(d)
endfunction
