first_time = %T;

function [t_petit, t_grand]=armijo(phi, phi0, dphi, dphi0, m1, m2, t)
    t_grand = phi > phi0 + m1 * dphi0 *t
    t_petit = %F // false, jamais trop petit
endfunction

function [t_petit, t_grand]=goldstein(phi, phi0, dphi, dphi0, m1, m2, t)
    t_grand = phi > phi0 + m1 * dphi0 * t 
    t_petit = phi < phi0 + m2 * dphi0 * t
endfunction

function [t_petit, t_grand]=wolfePowell(phi, phi0, dphi, dphi0, m1, m2, t)
    t_grand = phi > phi0 + m1 * dphi0 * t
    t_petit = phi < m2 * dphi0 *t
endfunction

function [t, interp_fail]=interpolation_c(t, a, b, f, gradf, xk, dk)
    tau = b - a
    c1 = tau*(gradf(xk+a*dk)'*dk+gradf(xk+b*dk)'*dk)+2*(f(xk+a*dk)-f(xk+b*dk))
    c2 = 3*(f(xk+b*dk)-f(xk+a*dk))-tau*(2*gradf(xk+a*dk)'*dk+gradf(xk+b*dk)'*dk)
    c3 = tau*(gradf(xk+a*dk)'*dk)
    if c2^2-3*c1*c3 >= 0 then
        s = (-c2*+sqrt(c2^2-3*c1*c3))/(3*c1)
    end
    if s >= 0 & s <= 1 then
        t = t + tau*s
        interp_fail = %F
    else
        interp_fail = %T
    end
endfunction

function [regle, dicho, m1, m2, c]=line_search_parameters()
    // Paramètres de la recherche linéaire
    m1 = input("m1 ? Press Enter to default to 0.1: ")
    if isempty(m1) then
        m1 = 0.1
    end
    
    m2 = input("m2 ? Press Enter to to 0.7: ")
    if isempty(m2) then
        m2 = 0.7
    end
    
    c = input("c ? c > 1! Press Enter to default to 2: ")
    if isempty(c) | c < 1 then
        c = 2
    end
    // Choix règle
    select input("Armijo (0), Goldstein (1), Wolfe-Powell (2) ? Defaults to Wolfe-Powell: ")
    case 0 then
        regle = armijo
        dicho = %T
    case 1 then
        regle = goldstein
        dicho = %T
    case 2 then
        regle = wolfePowell
        dicho = %F
    else
        regle = wolfePowell
        dicho = %F
    end
endfunction

function [t]=line_search(f, gradf, xk, dk, t, regle, dicho, m1, m2, c)
    // Recherche intervalle de départ
    a = 0
    [t_petit, t_grand] = regle(f(xk+t*dk), f(xk), gradf(xk+t*dk)'*dk, gradf(xk)'*dk, m1, m2, t)
    if ~t_petit & ~t_grand  then
        // t convient
        t = t
    elseif t_grand then
        // t trop grand
        b = t
    else
        while t_petit
            t = c*t
            [t_petit, t_grand] = regle(f(xk+t*dk), f(xk), gradf(xk+t*dk)'*dk, gradf(xk)'*dk, m1, m2, t)
        end
        if ~t_petit & ~t_grand  then
            // t convient
            return t
        end
        if t_grand then
            b = t
        end
    end
    // Réduction de l'intervalle
    while t_petit | t_grand then
        interp_fail = %F
        if ~dicho then
            [t, interp_fail] = interpolation_c(t, a, b, f, gradf, xk, dk)
            if interp_fail then
                dicho = %T
            end
        end
        if dicho | interp_fail then
            t = (a + b)/2
        end
        [t_petit, t_grand] = regle(f(xk+t*dk), f(xk), gradf(xk+t*dk)'*dk, gradf(xk)'*dk, m1, m2, t)
        if t_petit then
            a = t
        elseif t_grand then
            b = t
        end
        if (a-b) < %eps then
            t_petit = %F
            t_grand = %F
        end
    end
endfunction
