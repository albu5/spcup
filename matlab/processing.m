%%
u = Data(4,1).Power(1:end);
v = Data(4,1).Audio(1:end);

%%
n = 10000;
[b,a] = butter(20, 0.07*pi);
uf = filter(b, a, u);
plot(linspace(0, 1e3, n), abs(fft(v(1:n))));

k = enf(uf, 1e3, 1000, 500, 0.08*pi, 0.14*pi, 2^13);

%%
enf_rootmusic(u, 1e3, 8192, 4096, 0.16);
figure
enf_rootmusic(v, 1e3, 8192, 4096, 0.16);



%%
enf_fft(u, 1e3, 8192, 4096, 2^18, 0.08);
figure
enf_fft(v, 1e3, 8192, 4096, 2^18, 0.08);


%% spectograms
spectrogram(u,8192, 4096, 1000, 'yaxis');
colormap bone
figure
spectrogram(v,8192, 4096, 1000, 'yaxis');
colormap bone

%% ffft plot

n = 8192;
plot(linspace(0, 1e3, n), abs(fft(v(1:n))));
figure
plot(linspace(0, 1e3, n), abs(fft(u(1:n))));


%% next plan: create filter banks at fundamental of 50, 60 and their harmonics

