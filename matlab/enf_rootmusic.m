% function enf_var = enf_rootmusic(u, samprate, sampsize, overlap)

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

function enf_var = enf_rootmusic(u, samprate, sampsize, overlap, wc)

% samprate = 1000;      % 1KHz sampling rate given
% sampsize = 1024;      % thus, resolution is ~1 sec
% overlap = 512;        % ~0.5 sec overlap
% wlow = 0.08*pi;       % 40 Hz
% whigh = 0.14*pi;      % 70 Hz

[b, a] = butter(20, wc);     % ~100 hz cutoff
% specify your own u vector which contains recordings------------
% u = v(1:100000);
% ---------------------------------------------------------------

enf_var  = [];          % contains enf data, i.e. freq wrt time
i = 1;
while i<numel(u)-sampsize
    uu = u(i+1:i+sampsize);
    uu = hamming(sampsize).*uu(:);
    uu = filter(b, a, uu);
    [S, ~] = rootmusic(uu, 2, samprate);
    temp = S(1);
    if temp>90 && temp<130
        temp = temp/2;
    elseif temp>140 && temp<190
        temp = temp/3;
    elseif temp>195 && temp<245
        temp = temp/4;
    end
    enf_var(end+1) = temp;
    i = i + overlap;
    display(num2str(i/numel(u)));
end
plot(enf_var);
end
