%%
u = Data(2,1).Power(1:end);
v = Data(2,1).Audio(1:end);

u1 = Data(4,1).Power(1:end);
v1 = Data(4,1).Audio(1:end);

u2 = Data(6,1).Power(1:end);
v2 = Data(6,1).Audio(1:end);

u3 = Data(8,1).Power(1:end);
v3 = Data(8,1).Audio(1:end);

%%
n = 10000;
[b,a] = butter(20, 0.07*pi);
uf = filter(b, a, u);
plot(linspace(0, 1e3, n), abs(fft(v(1:n))));

k = enf(uf, 1e3, 1000, 500, 0.08*pi, 0.14*pi, 2^13);

%%
enf_rootmusic(u1, 1e3, 8192, 4096, 0.16);
figure
enf_rootmusic(v1, 1e3, 8192, 4096, 0.16);



%%
enf_fft(u, 1e3, 8192, 4096, 2^18, 0.08);
figure
enf_fft(v, 1e3, 8192, 4096, 2^18, 0.08);


%% spectograms
spectrogram(u1,8192, 4096,1000, 'yaxis');
colormap bone
figure
spectrogram(v1,8192, 4096,1000, 'yaxis');
colormap bone


%% ffft plot

n = 8192;
plot(linspace(0, 1e3, n), abs(fft(v(1:n))));
figure
plot(linspace(0, 1e3, n), abs(fft(u(1:n))));


%% next plan: create filter banks at fundamental of 50, 60 and their harmonics

%% cepstrum analysis

[F0, T, C] = spPitchTrackCepstrum(v(1:8000), 1000, 30,20, 'hamming', 'plot');
%% Autocorr method
ru = autocorr(v(1:8000), 50);
plot(ru)

%% HPS
close all
hpsadd = spHps( v(1:8192), 1e3, 'add', 2^20, 1);
figure
hpsmul = spHps( v(1:8192), 1e3, 'multiply', 2^20, 1);
figure
plot(linspace(0,1000, 2^20), abs(fft(v(1:8192), 2^20)));


%%
y = spHpsTrack(v1, 1e3, 8192, 4096, 2^20);
y1 = spHpsTrack(u1, 1e3, 8192, 4096, 2^20);

n = numel(y);
n1 = numel(y1);

t = linspace(0,4096*n/1000, n);
t1 = linspace(0,4096*n1/1000, n1);

%%
plot(t,y)
xlabel('Time in seconds')
ylabel('ENF estimate in Hz')
title('Audio Signal ENF')
figure
plot(t1,y1)
xlabel('Time in seconds')
ylabel('ENF estimate in Hz')
title('Power Signal ENF')

%%

%%
a_home_s = spHpsTrack(a_home(1:1000000), 1e3, 8192, 4096, 2^20);
p_home_s = spHpsTrack(p_home(1:1000000), 1e3, 8192, 4096, 2^20);

a_school_1_s = spHpsTrack(a_school_1(1:1000000), 1e3, 8192, 4096, 2^20);
p_school_1_s = spHpsTrack(p_school_1(1:1000000), 1e3, 8192, 4096, 2^20);

a_school_2_s = spHpsTrack(a_school_2(1:1000000), 1e3, 8192, 4096, 2^20);
p_school_2_s = spHpsTrack(p_school_2(1:1000000), 1e3, 8192, 4096, 2^20);

a_school_3_s = spHpsTrack(a_school_3(1:1000000), 1e3, 8192, 4096, 2^20);
p_school_3_s = spHpsTrack(p_school_3(1:1000000), 1e3, 8192, 4096, 2^20);
