function x1 = harmf(x)

n = numel(x);
p = (n-1)/2;
x1 = x;
x1(1:p) = x1(1:p) + ((1:p)')*x(end);
