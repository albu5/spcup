practice_dir = 'C:\Users\Ashish\OneDrive\spcup\Practice_dataset\';
matlab_dir = 'C:\Users\Ashish\OneDrive\spcup\matlab\';

cd(practice_dir);
files = dir('*.wav');
cd(matlab_dir);

for file = files'
    x = audioread([practice_dir file.name]);
    nominalf(x, 'add');
    pause
    close all
end
