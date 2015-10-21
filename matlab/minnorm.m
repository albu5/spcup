% iv. Minimum-norm method for a single complex exponential using 8 × 8
% autocorrelation matrix. Use the covariance method to estimate the 
% correlation matrix
function [ps, ws] = minnorm(v, n)
R = autocorr_cov(v, 8);
[V, ~] = eig(R);
Vn = V(:,1:end-2);
u1 = zeros(size(Vn,1), 1); u1(1) = 1;
a = (Vn*Vn'*u1)/(u1'*(Vn*Vn')*u1);
ps = fft(a, n);
ps = 1./((abs(ps)).^2);
ws = linspace(0,2*pi,n); 
end

function R = autocorr_cov(v, p)
AC = circulant(transpose(v(:)));
AC1 = AC(1:p, p+1:end);
R = AC1*ctranspose(AC1);
end

function C = circulant(varargin)

if nargin>1
    dir = varargin{2};
else
    dir = 1;
end
A = varargin{1};
if size(A,1)>1 && size(A,2)>1
    error('Input must be a vector')
end
isrow = size(A,2)>size(A,1);
A = A(:);
B = dir*(0:numel(A)-1);
C = bsxfun(@circshift, A, B);
if isrow
    C = C';
end

end