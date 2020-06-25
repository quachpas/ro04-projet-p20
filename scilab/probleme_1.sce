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
[xk, k, iterations, times] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

// Contour plot
contour_plot = scf(0)
title("Tracé des contours de la fonction de Rosenbrock avec p = 100 et des itérations de la méthode de Newton-Raphson", 'fontsize', -1)
x = linspace(-1.5, 1.5, 100);
y = linspace(-3.5, 1.5, 100);
xset("fpf"," ") // no contour labels
contour(x, y, plot_rosenbrock, 50, mode=2);
scatter(iterations(1,:), iterations(2,:))
for i = 1:k-1
    xarrows(iterations(1,i:i+1), iterations(2,i:i+1), 0.01)
end

// Convergence plot
convergence_plot = scf(1)
title("Norme du gradient de Rosenbrock évalué en x_k en fonction de l itération k", 'fontsize', -1)
cv_points = []
for i = 1:k
    cv_points = [cv_points;norm(iterations(:,i))]
end
plot(1:k, cv_points)

// Ordre de convergence plot
ordre_convergence_plot = scf(2)
title("Ordre de convergence de la méthode de Newton-Raphson en fonction de l itération k", 'fontsize', -1)
ocv = []
for i = 1:k-1
    ocv = [ocv, abs(cv_points(i+1)-norm(sol, 2))/abs(cv_points(i)-norm(sol,2))]
end
plot(1:k-1, ocv)

// Time plot
plot_time_per_it = scf(3)
title("Moyenne du temps écoulé en fonction de l itération k pour 200 exécutions")
times = [] // Premier appel ignoré dû au caching
for it=1:200
    [xk, k, iterations, time_per_it] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0], 10^(-10), 10000);
    times = [times, time_per_it]
end
plot(1:k-1, mean(times, 'c'))









