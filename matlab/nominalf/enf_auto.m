function [nominalfreq, enf] = enf_auto(varargin)
%%
% Inputs:   f: function handle for f(x)
%           x: "a priori" state estimate
%           P: "a priori" estimated state covariance
%           h: function handle for h(x)
%           z: current measurement
%           Q: process noise covariance
%           R: measurement noise covariance
f = @harmf;
h = @harmh;

fs = 1e3;

% frequencies for grids, change nominal_freq accordingly
% A 60
% B 50
% C 60
% D 50
% E 50
% F 50
% G 50
% H 50
% I 60
nominal_freq = [50 60];

w0 = 2*pi*nominal_freq/fs;

%%

data = varargin{1};

% data = audioread([filename '.wav']);
%     data = data(1:20000);

if mean(data(1:2))>0.25
    phase_init = pi;
elseif mean(data(1:2))<-0.25
    phase_init = -pi;
else
    phase_init = 0;
end


x = ([phase_init,phase_init, phase_init,0.5, 0.25, 0.125, w0(1)]');
P = diag([pi*pi, pi*pi, pi*pi, 0.25, 0.25, 0.25, 1e-8*pi*pi]);
Q = diag([0, 0, 0, 1e-10, 1e-10, 1e-10, 1e-12*pi]);
R = 0.01;

%%
X1 = [];
dc = 1;
for i = 1:numel(data)
    [x, P] = ekf(f,x,P,h,data(i),Q,R);            % ekf
    X1(i) = x(end);
    
    r = i/numel(data);
    if r>dc/10
        dc = dc+1;
        display(num2str(100*r));
    end
end
P1 = P;

x = ([phase_init,phase_init, phase_init,0.5, 0.25, 0.125, w0(2)]');
P = diag([pi*pi, pi*pi, pi*pi, 0.25, 0.25, 0.25, 1e-8*pi*pi]);
Q = diag([0, 0, 0, 1e-10, 1e-10, 1e-10, 1e-12*pi]);
R = 0.01;

X2 = [];
dc = 1;
for i = 1:numel(data)
    [x, P] = ekf(f,x,P,h,data(i),Q,R);            % ekf
    X2(i) = x(end);
    
    r = i/numel(data);
    if r>dc/10
        dc = dc+1;
        display(num2str(100*r));
    end
end
P2 = P;

display(P1)
display((0.5*fs/pi)*mean(X1))

display(P2)
display((0.5*fs/pi)*mean(X2))

figure
subplot(1, 2, 1), plot((0.5*fs/pi)*X1)
subplot(1, 2, 2), plot((0.5*fs/pi)*X2)

if sum(diag(P1))>sum(diag(P2))
    enf = (0.5*fs/pi)*X2;
    nominalfreq = (0.5*fs/pi)*mean(X2);
else
    enf = (0.5*fs/pi)*X1;
    nominalfreq = (0.5*fs/pi)*mean(X1);
end
