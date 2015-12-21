
% change this to folder of power recording of your assigned grid
data_dir = 'C:\Users\Ashish\OneDrive\spcup\Practice_dataset\';

% change this to whereever test1.m is (spcup/matlab/ekf)
mat_dir = 'C:\Users\Ashish\OneDrive\spcup\matlab\nominalf';


cd(data_dir)
files = dir('*.wav');
cd(mat_dir)

%%
N = numel(files);

for i = 1:N
    filename = files(i).name;
    data = audioread([data_dir filename]);
%     data = data(1:1000);
    [nf, enf] = enf_auto(data);
    files(i).frequency = nf;
    save([data_dir filename(1:end-4) '_enf'], 'enf');
end

save([data_dir 'info'], 'files');