getd('.')

for i = 0:3
    clf(i)
end

// Point initial
x0 = -1
y0 = 1

// Solution + ordre de convergece
sol = [1;1]

// Line search parameters 
[regle, dicho, m1, m2, c]=line_search_parameters()

// newton_raphson
disp("NEWTON-RAPHSON")
[xk_nr, k_nr, iterations_nr, times_nr] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

// BFGS
disp("BFGS")
[xk_bfgs, k_bfgs, iterations_bfgs, times_bfgs, reset_counter] = BFGS(rosenbrock, gradrosenbrock, [x0;y0], eye(2,2));

k_nr = size(iterations_nr, 'c')
k_bfgs = size(iterations_bfgs, 'c')
// Contour plot
contour_plot = scf(0)
title("Tracé des contours de la fonction de Rosenbrock avec p = 100 et des itérations de la méthode de Newton-Raphson", 'fontsize', -1)
x = linspace(-1.5, 1.5, 100);
y = linspace(-3.5, 1.5, 100);
xset("fpf"," ") // no contour labels
contour(x, y, plot_rosenbrock, 50);
scatter(iterations_nr(1,:), iterations_nr(2,:), '+', "markerEdgeColor", [1 0 0])
// BFGS ne marche pas
//scatter(iterations_bfgs(1,:), iterations_bfgs(2,:), '+', "markerEdgeColor", [0 0 1])
for i = 1:k_nr-1
    xarrows(iterations_nr(1,i:i+1), iterations_nr(2,i:i+1), 0.1, 5)
end
for i = 1:k_bfgs-1
//    xarrows(iterations_bfgs(1,i:i+1), iterations_bfgs(2,i:i+1), 0.1, 2)
end
legend(['Newton-Raphson'])

// Convergence plot
convergence_plot = scf(1)
title("Norme du gradient de Rosenbrock évalué en x_k en fonction de l itération k", 'fontsize', -1)
cv_nr = []
cv_bfgs = []
for i = 1:k_nr
    cv_nr = [cv_nr;norm(iterations_nr(:,i))]
end
for i = 1:k_bfgs
//    cv_bfgs = [cv_bfgs;norm(iterations_bfgs(:,i))]
end
plot(1:k_nr, cv_nr, 'r')
//plot(1:k_bfgs, cv_bfgs, 'b')
legend(['Newton-Raphson'])

// Ordre de convergence plot
ordre_convergence_plot = scf(2)
title("Ordre de convergence des méthodes de Newton-Raphson et BFGS en fonction de l itération k", 'fontsize', -1)
ocv_nr = []
ocv_bfgs = []
for i = 1:k_nr-1
    ocv_nr = [ocv_nr, abs(cv_nr(i+1)-norm(sol, 2))/abs(cv_nr(i)-norm(sol,2))]
end
for i = 1:k_bfgs-1
//    ocv_bfgs = [ocv_bfgs, abs(cv_bfgs(i+1)-norm(sol, 2))/abs(cv_bfgs(i)-norm(sol,2))]
end
plot(1:k_nr-1, ocv_nr, 'r')
//plot(1:k_bfgs-1, ocv_bfgs, 'b')
legend(['Newton-Raphson'])

// Time plot
plot_time_per_it = scf(3)
title("Moyenne du temps écoulé en fonction de l itération k pour 50 exécutions")
times_nr = [] // Premier appel ignoré dû au caching
times_bfgs = []
for it=1:50
    [xk_nr, k_nr, iterations_nr, time_nr] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0], 10^(-10), 10000);
    times_nr = [times_nr, time_nr]
//    [xk_bfgs, k_bfgs, iterations_bfgs, time_bfgs, reset_counter] = BFGS(rosenbrock, gradrosenbrock, [x0;y0], eye(2,2), 10^(-10), 10000);
//    times_bfgs = [times_bfgs, time_bfgs]
end
plot(1:k_nr-1, mean(times_nr, 'c'), 'r')
//plot(1:k_bfgs-1, mean(times_bfgs, 'c'), 'b')
legend(['Newton-Raphson'])



