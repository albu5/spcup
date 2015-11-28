function z = harmh(x)
n = numel(x);
p = (n-1)/2;
phi = x(1:p);
ampt = x(p+1:2*p);
z = sum(ampt.*sin(phi));