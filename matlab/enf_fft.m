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

function enf_var = enf_fft(u, samprate, sampsize, overlap, nfft, wc)

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

enf_var  = [];          % contains enf data, i.e. freq wrt time
i = 1;
w =linspace(0,samprate, nfft);
while i<numel(u)-sampsize
    uu = u(i+1:i+sampsize);
    %     uf = filter(b, a, uu);
    S = fft(uu, nfft);
    %     plot(w, abs(S))
    %     pause
    [~, idx] = max(abs(S));
    temp = w(idx);
    if temp<65
        temp = temp;
    elseif temp>95 && temp<125
        temp = temp/2;
    elseif temp>145 && temp<185
        temp = temp/3;
    elseif temp>195 && temp<245
        temp = temp/4;
    else
        temp = temp;
    end
    enf_var(end+1) = temp;
    i = i + overlap;
    
    r = i/numel(u);
    if r>dc/10
        dc = dc+1;
        display(num2str(100*r));
    end
end

% remove ouutliers
medval = nanmedian(enf_var);
enf_var(abs(enf_var-medval)>1) = NaN;

plot(enf_var);

