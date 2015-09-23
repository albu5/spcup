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

function enf_var = enf(u, samprate, sampsize, overlap, wlow, whigh, nfft)

% samprate = 1000;    % 1KHz sampling rate given
% sampsize = 100;    % thus, resolution is 1 sec
% overlap = 50;      % 0.5 sec overlap

w = linspace(wlow, whigh, nfft);

% specify your own u vector which contains recordings------------
% u = v(1:100000);
% ---------------------------------------------------------------

enf_var  = [];          % contains enf data, i.e. freq wrt time
i = 1;
while i<numel(u)-sampsize
    [S, ws] = pmusic(u(i:i+sampsize), 2, w);
    [~, idx] = max(S);
    enf_var(end+1) = ws(idx);
    i = i + overlap;
    display(i/numel(u));
end
enf_var = enf_var*samprate/(2*pi);
plot(enf_var);
end
