function [] = nominalf(varargin)

if nargin==1
    method = 'add';
else
    method = varargin{2};
end


fs = 1e3;

x = varargin{1};
x = x(:);

xf = abs(fft(x, 2^20));
N = numel(xf);
plot(linspace(0,fs, N), xf);

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

ff = linspace(0,fs, N);
figure;
plot(ff, hps);
figure;
plot(ff, hps'.*exp(-10*abs(ff-50)) + hps'.*exp(-10*abs(ff-60)))