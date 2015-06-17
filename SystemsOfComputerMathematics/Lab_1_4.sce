function dx = f (t, x)
    dx(1) = x(2);
    dx(2) = -x(1) - 2*0.15*x(2) + 20*sin(5* t);
endfunction

t = 0:0.05:25;

y = ode([0.5; 0], 0, t, f);

plot2d(t', [y(1,:)' y(2, :)'])
