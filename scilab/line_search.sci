function [t_petit, t_grand]=armijo(phi, phi0, dphi0, m1, m2, t)
    t_grand = phi > phi0 + m1 * dphi0 *t
    t_petit = %F // false, jamais trop petit
endfunction

function [t_petit, t_grand]=goldstein(phi, phi0, dphi0, m1, m2, t)
    t_grand = phi > phi0 + m1 * dphi0 * t 
    t_petit = phi < phi0 + m2 * dphi0 * t
endfunction

function [t_petit, t_grand]=wolfePowell(phi, phi0, dphi0, m1, m2, t)
    t_grand = 
    t_petit = 
endfunction


function [t]=line_search(f, gradf, xk, dk, t0)
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
    c = input("c ? Press Enter to default to 2: ")
    if isempty(c) then
        c = 2
    end
    disp("c = " + string(c))
    // Choix règle
    select input("Armijo (0), Goldstein (1), Wolfe-Powell (2) ? Defaults to Wolfe-Powell: ")
    case 0 then
        regle = armijo
        disp("Armijo choisie")
    case 1 then
        regle = goldstein
        disp("Goldstein choisie")
    case 2 then
        regle = wolfePowell
        disp("Wolfe-Powell choisie")
    else
        regle = wolfePowell
        disp("Wolfe-Powell choisie")
    end
    
    [t_petit, t_grand] = regle()
endfunction
