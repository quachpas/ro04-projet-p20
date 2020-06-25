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
[xk_nr, k_nr, iterations_nr, times_nr] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

// BFGS
[xk_bfgs, k_bfgs, iterations_bfgs, times_bfgs, reset_counter] = BFGS(rosenbrock, gradrosenbrock, [x0;y0], eye(2,2));

// Contour plot
contour_plot = scf(0)
title("Tracé des contours de la fonction de Rosenbrock avec p = 100 et des itérations de la méthode de Newton-Raphson et BFGS", 'fontsize', -1)
x = linspace(-1.5, 1.5, 100);
y = linspace(-3.5, 1.5, 100);
xset("fpf"," ") // no contour labels
contour(x, y, plot_rosenbrock, 50);
scatter(iterations_nr(1,:), iterations_bfgs(2,:), '+', "markerEdgeColor", [1 0 0])
scatter(iterations_bfgs(1,:), iterations_bfgs(2,:), '+', "markerEdgeColor", [1 0 0])
for i = 1:k-1
    xarrows(iterations(1,i:i+1), iterations(2,i:i+1), 0.1, 5)
end

// Convergence plot
convergence_plot = scf(1)
title("Norme du gradient de Rosenbrock évalué en x_k en fonction de l itération k", 'fontsize', -1)
cv_points = []
for i = 1:k
    cv_points = [cv_points;norm(iterations(:,i))]
end
plot(1:k, cv_points, 'r')


// Ordre de convergence plot
ordre_convergence_plot = scf(2)
title("Ordre de convergence de la méthode de Newton-Raphson en fonction de l itération k", 'fontsize', -1)
ocv = []
for i = 1:k-1
    ocv = [ocv, abs(cv_points(i+1)-norm(sol, 2))/abs(cv_points(i)-norm(sol,2))]
end
plot(1:k-1, ocv, 'r')

// Time plot
plot_time_per_it = scf(3)
title("Moyenne du temps écoulé en fonction de l itération k pour 200 exécutions")
times = [] // Premier appel ignoré dû au caching
for it=1:200
    [xk, k, iterations, time_per_it] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0], 10^(-10), 10000);
    times = [times, time_per_it]
end
plot(1:k-1, mean(times, 'c'), 'r')



// Contour plot
scf(contour_plot)
x = linspace(-1.5, 1.5, 100);
y = linspace(-3.5, 1.5, 100);
xset("fpf"," ") // no contour labels
scatter(iterations(1,:), iterations(2,:))
for i = 1:k-1
    xarrows(iterations(1,i:i+1), iterations(2,i:i+1), 0.01)
end
legend(['Newton-Raphson';'BFGS'])

// Convergence plot
scf(convergence_plot)
cv_points = []
for i = 1:k
    cv_points = [cv_points;norm(iterations(:,i))]
end
plot(1:k, cv_points)
legend(['Newton-Raphson';'BFGS'])
// Ordre de convergence plot
scf(ordre_convergence_plot)
ocv = []
for i = 1:k-1
    ocv = [ocv, abs(cv_points(i+1)-norm(sol, 2))/abs(cv_points(i)-norm(sol,2))]
end
plot(1:k-1, ocv)
legend(['Newton-Raphson';'BFGS'])
// Time plot
scf(plot_time_per_it)
times = [] // Premier appel ignoré dû au caching
for it=1:2
    [xk, k, iterations, times, reset_counter] = BFGS(rosenbrock, gradrosenbrock, [x0;y0], eye(2,2));
    times = [times, time_per_it]
end
plot(1:k-1, mean(times, 'c'))
legend(['Newton-Raphson';'BFGS'])
















