% function y = filterenf(x)
% This function filters input signal to search just f0r frequencies in the
% range of 50 +- tol Hz and and 60 +- tol Hz 

function y = filterenf(x, samprate)
tol = 2;
order = 15;
y = zeros(size(x));
for i = 1:5
[b1, a1] = butter(order, [i*2*(50-tol)/samprate i*2*(50+tol)/samprate], 'bandpass');
[b2, a2] = butter(order, [i*2*(60-tol)/samprate i*2*(60+tol)/samprate], 'bandpass');
y = y + filter(b1, a1, x) + filter(b2, a2, x);
end