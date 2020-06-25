getd('.')

x0 = -1
y0 = 1
[xk, k, iterations] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

x = linspace(-3, 1.5, 100);
y = linspace(-3, 1.5, 100);

// no contour labels
xset("fpf"," ")
contour(x, y, plot_rosenbrock, 50, mode=2);
scatter(iterations(1,1:size(iterations,'c')), iterations(2,1:size(iterations,'c')))








