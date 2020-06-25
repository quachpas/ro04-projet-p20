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
        return [t + (tau/3*c1)*(-c2*+sqrt(c2^2-3*c1*c2)), %F]
    else 
        return [t, %T]
    end
endfunction

function [t]=line_search(f, gradf, xk, dk, t)
    // Paramètres de la recherche linéaire
    m1 = input("m1 ? Press Enter to default to 0.1: ")
    if isempty(m1) then
        m1 = 0.1
    end
    disp("m1 = " + string(m1))
    m2 = input("m2 ? Press Enter to to 0.7: ")
    if isempty(m2) then
        m2 = 0.7
    end
    disp("m2 = " + string(m2))
    c = input("c ? c > 1! Press Enter to default to 2: ")
    if isempty(c) | c < 1 then
        c = 2
    end
    disp("c = " + string(c))
    // Choix règle
    select input("Armijo (0), Goldstein (1), Wolfe-Powell (2) ? Defaults to Wolfe-Powell: ")
    case 0 then
        regle = armijo
        dicho = %T
        disp("Armijo choisie")
    case 1 then
        regle = goldstein
        dicho = %T
        disp("Goldstein choisie")
    case 2 then
        regle = wolfePowell
        dicho = %F
        disp("Wolfe-Powell choisie")
    else
        regle = wolfePowell
        dicho = %F
        disp("Wolfe-Powell choisie")
    end

    // Recherche intervalle de départ
    a = 0
    [t_petit, t_grand] = regle(f(xk+t*dk), f(xk), gradf(xk+t*dk)'*dk, gradf(xk)'*dk, m1, m2, t)
    if ~t_petit & ~t_grand  then
        // t convient
        return t
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
    while ~t_petit & ~t_grand then
        interp_fail = %F
        if ~dicho then
            [t, interp_fail] = interpolation_c(t, a, b, f, gradf, xk, dk)
        elseif dicho | interp_fail then
            t = (a + b)/2
        end
        [t_petit, t_grand] = regle(f(xk+t*dk), f(xk), gradf(xk+t*dk)'*dk, gradf(xk)'*dk, m1, m2, t)
    end
endfunction
