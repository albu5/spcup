function enf_var = spHpsTrack (u, samprate, sampsize, overlap, nfft)

% samprate = 1000;      % 1KHz sampling rate given
% sampsize = 1024;      % thus, resolution is ~1 sec
% overlap = 512;        % ~0.5 sec overlap
% wlow = 0.08*pi;       % 40 Hz
% whigh = 0.14*pi;      % 70 Hz
% this function calculates the frequency variation from recording vector v
% using minnorm method with p = 1 for getting frequency which should be
% centered around 50Hz (60Hz)
% since sampling frequency is 1000Hz, this amounts to 0.1pi (0.12pi).
%
% One of the parameters here isresolution in time apart which frequency is
% estimated. More the resolution, lesser the samples and poorer the
% frequency estimate. Here res = sampling_freq/sampsize.
% another paramter is overlap, i.e. how much overlap is chosen between
% successive estimates.
% Note that resolution in frequency domain must be high (nfft)

% samprate = 1000;      % 1KHz sampling rate given
% sampsize = 1024;      % thus, resolution is ~1 sec
% overlap = 512;        % ~0.5 sec overlap
% wlow = 0.08*pi;       % 40 Hz
% whigh = 0.14*pi;      % 70 Hz

% [b, a] = butter(10, wc, 'high');     % ~40 hz cutoff
% specify your own u vector which contains recordings------------
% u = v(1:100000);
% ---------------------------------------------------------------
dc = 1;
lambda = -0.25;
enf_var  = [];          % contains enf data, i.e. freq wrt time
i = 1;

w = linspace(0,samprate, nfft);
ml = exp(abs(w-60)/lambda);
ml = ml';
while i<numel(u)-sampsize
    uu = u(i+1:i+sampsize);
    S = spHps( uu, samprate, 'multiply', nfft, 0);
    %     plot(w, abs(S))
    %     pause
    S = S.*ml;
    [~, idx] = max(abs(S));
    temp = w(idx);
    enf_var(end+1) = temp;
    i = i + overlap;
    
    r = i/numel(u);
    if r>dc/10
        dc = dc+1;
        display(num2str(100*r));
    end
end
plot(enf_var);

