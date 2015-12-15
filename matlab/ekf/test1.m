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
nominal_freq = 60;

w0 = 2*pi*nominal_freq/fs;

% change this to folder of power recording of your assigned grid
data_dir = 'C:\Users\Ashish\OneDrive\spcup\datasets\Grid_C\Power_recordings\';

% change this to whereever test1.m is (spcup/matlab/ekf)
mat_dir = 'C:\Users\Ashish\OneDrive\spcup\matlab\ekf\';

% now run this script. make sure uto hibernate/sleep/shut don is turned off.
% push changes into github


cd(data_dir)
files = dir('*.wav');
cd(mat_dir)

%%

for file = files'
    filename = file.name;
    data = audioread([data_dir filename]);

    % data = audioread([filename '.wav']);
%     data = data(1:20000);
    
    if mean(data(1:2))>0.25
        phase_init = pi;
    elseif mean(data(1:2))<-0.25
        phase_init = -pi;
    else
        phase_init = 0;
    end
    
    
    x = ([phase_init,phase_init, phase_init,0.5, 0.25, 0.125, w0]');
    P = diag([pi*pi, pi*pi, pi*pi, 0.25, 0.25, 0.25, 1e-8*pi*pi]);
    Q = diag([0, 0, 0, 1e-10, 1e-10, 1e-10, 1e-12*pi]);
    R = 0.01;
    
    %%
    X = [];
    dc = 1;
    for i = 1:numel(data)
        [x, P] = ekf(f,x,P,h,data(i),Q,R);            % ekf
        X(i) = x(end);
        
        r = i/numel(data);
        if r>dc/10
            dc = dc+1;
            display(num2str(100*r));
        end
    end
    enf = (0.5*fs/pi)*X;
    save([data_dir filename(1:end-4) '_enf'], 'enf');
%     plot(enf);
%     break;
end