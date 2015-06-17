fmin = 1;
fmax = 20000000;
df = (fmax - fmin)/20;
F = fmin:df:fmax;
R = 20000;
L = 10^-5;
C = 10^-12;
for i = 1:1:21
    W(i) = 2*%pi*F(i);
    k(i) = abs((1/(%i*W(i)*C))/(R+(%i*W(i)*L)+1/(%i*W(i)*C)));
end
plot(W, k);
