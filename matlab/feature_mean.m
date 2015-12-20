clear
clc

%%
arr = ['A','B','C','D','E','F','G','H','I'];
s = 0;
%%
for l = 1:length(arr)
    data_dir = strcat('C:\Users\Ashish\OneDrive\spcup\datasets\Grid_',arr(l),'\Power_recordings\');
    cd(data_dir)
    files = dir('*.mat');

    segment_l = 300000;
    j=0;
    for file = files'
        j = j+1;
        filename = file.name;
        display([data_dir filename]);
        data = load([data_dir filename]);
        A = data.enf;
        n(j) = ceil(length(A)/segment_l);
        for i=1:n(j)
            K = A(1+(i-1)*segment_l:i*segment_l);
            feature_m(s+i,1) = l;
            feature_m(s+i,2) = mean(K);
            feature_m(s+i,3) = log(max(K)-min(K));
            [C,L] = wavedec(K,4,'db1');
            feature_m(s+i,4) = var(C(1:L(1)));
            feature_m(s+i,5) = var(C(L(1)+1:L(1)+L(2)));
            feature_m(s+i,6) = var(C(L(1)+L(2)+1:L(1)+L(2)+L(3)));
            feature_m(s+i,7) = var(C(L(1)+L(2)+L(3)+1:L(1)+L(2)+L(3)+L(4)));
            feature_m(s+i,8) = var(C(L(1)+L(2)+L(3)+L(4)+1:L(6)));
            m = ar(K,2);
            feature_m(s+i,9) = m.a(2);
            feature_m(s+i,10) = m.a(3);
            feature_m(s+i,11) = m.NoiseVariance;
        end
        s = s+n(j);    
    end
end

data = feature_m(:,2:end);
labels = feature_m(:,1);
nomf = data(:,1);

f50 = nomf<55;
f60 = nomf>55;

data50 = data(f50, :);
data60 = data(f60, :);
label50 = labels(f50);
label60 = labels(f60);

data50 = array2table(data50);
data60 = array2table(data60);
data50.class = categorical(label50);
data60.class = categorical(label60);