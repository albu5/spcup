clear
clc

%%
mat_dir = 'C:\Users\Ashish\OneDrive\spcup\matlab\features\';
arr = ['A','B','C','D','E','F','G','H','I'];
feature_m = [];
label_m = [];
label_int = [];
seg_jump = 150000;
seg_len = 300000;
%%
for l = 1:length(arr)
    data_dir = strcat('C:\Users\Ashish\OneDrive\spcup\datasets\Grid_',arr(l),'\Power_recordings\');
    cd(data_dir)
    files = dir('*.mat');
    cd(mat_dir)
    for file = files'
        filename = file.name;
        display([data_dir filename]);
        data = load([data_dir filename]);
        A = data.enf;
        j = 1;
        while j<numel(A)-seg_len
            seg_enf = A(j:j+seg_len);
            j = j+seg_jump;
%             display(num2str(j*100/numel(A)))
            feature_m(end+1,:) = feature_vec(seg_enf);
            label_m(end+1,1) = arr(l);
            label_int(end+1,1) = l;
        end
    end
end


%%
% data = feature_m(:,2:end);
% labels = feature_m(:,1);
% nomf = data(:,1);
% 
% f50 = nomf<55;
% f60 = nomf>55;
% 
% data50 = data(f50, :);
% data60 = data(f60, :);
% label50 = labels(f50);
% label60 = labels(f60);
% 
% data50 = array2table(data50);
% data60 = array2table(data60);
% data50.class = categorical(label50);
% data60.class = categorical(label60);