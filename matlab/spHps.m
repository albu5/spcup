function [ hps ] = spHps( x, fs, method, res, show)
% function [ hps ] = spHps( x, fs, show )
% This function will return Harmomic product spctrum of signal x
% input:
% x : input signal
% fs : sampling frequency
% method : 'add' or 'multiply'
% show : weather to show a plot of hps
% output:
% hps : Harmomic product spctrum
x = x(:);

xf = abs(fft(x, res));
N = numel(xf);

xf2 = downsample(xf, 2);
xf2 = [xf2;zeros(N-numel(xf2), 1)];

xf3 = downsample(xf, 3);
xf3 = [xf3;zeros(N-numel(xf3), 1)];

xf4 = downsample(xf, 4);
xf4 = [xf4;zeros(N-numel(xf4), 1)];

xf5 = downsample(xf, 5);
xf5 = [xf5;zeros(N-numel(xf5), 1)];

xf6 = downsample(xf, 4);
xf6 = [xf6;zeros(N-numel(xf6), 1)];

switch method
    case 'multiply'
        hps = xf.*xf2.*xf3.*xf4.*xf5.*xf6;
    case 'add'
        hps = xf + xf2 + xf3 + xf4 + xf5 + xf6;
end

if show
    plot(linspace(0,fs, N), hps)
end

end

