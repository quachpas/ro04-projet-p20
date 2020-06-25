getd('.')
// skip line_search parameters
// first_time = %F
m1 = 0.1
m2 = 0.7

x0 = -1
y0 = 1
[xk, k, iterations] = newton_raphson(rosenbrock, gradrosenbrock, hessrosenbrock, [x0;y0]);

x = linspace(-1.5, 1.5, 100);
y = linspace(-3.5, 1.5, 100);

// no contour labels
clf()
xset("fpf"," ")
contour(x, y, plot_rosenbrock, 50, mode=2);
scatter(iterations(1,:), iterations(2,:))
for i = 1:size(iterations,'c')-1
    xarrows(iterations(1,i:i+1), iterations(2,i:i+1), 0.01)
end









