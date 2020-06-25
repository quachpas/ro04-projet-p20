function [t_grand]=armijo()
endfunction

function [t_petit, t_grand]=wolfePowell()
endfunction

function [t_petit, t_grand]=goldstein()
endfunction

function [t]=line_search(f, gradf, xk, dk, t0)
    // Paramètres de la recherche linéaire
    m1 = input("m1 ? Press Enter to default to 0.1")
    if isempty(m1) then
        m1 = 0.1
    end
    m2 = input("m2 ? Press Enter to to 0.7")
    if isempty(m2) then
        m2 = 0.7
    end
    c = input("c ? Press Enter to default to 2")
    if isempty(c) then
        c = 2
    end
    disp(m1, m2, c)
endfunction
