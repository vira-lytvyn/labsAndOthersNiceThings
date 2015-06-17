function dx = f (t, x)
    dx(1) = x(2);
    dx(2) = 2 * (1 - x(1)^2) * x(2) - x(1);
endfunction

t = 0:0.05:25;

y = ode([1; 1], 0, t, f);

plot2d(y(1,:), y(2, :))
