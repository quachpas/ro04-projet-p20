getd('.')

clf()

// Point initial
x0 = -1
y0 = 1

// newton_raphson
[xk, k, iterations] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

// Contour plot
contour_plot = scf(0)
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
cv_points = []
for i = 1:k
    cv_points = [cv_points;norm(iterations(:,i))]
end
plot(1:k',cv_points)









