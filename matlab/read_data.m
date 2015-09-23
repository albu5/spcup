% this function reads training data from datasets folder and gives it ass
% output in an array of structures, rows being observations for a
% particular grid. Each struct has two recordings, Audio and Power. Change
% labels array in the function and give datasets directory as an input
% argument to run the function
function train_data = read_data(directory)
cd(directory)
labels = ['A';'B';'C';'D';'E';'F';'G';'H';'I'];

i = 1;
for label  = labels'
   display(['Reading recordings for grid ' label])
   cd(['Grid_' label '\Audio_recordings\'])
   files = dir('*.wav');
   j = 1;
   for file = files'
       train_data(i,j).Audio = audioread(file.name);
       j = j+1;
   end
   
   cd ..\Power_recordings\
   files = dir('*.wav');
   j = 1;
   for file = files'
       train_data(i,j).Power = audioread(file.name);
       j = j+1;
   end
   
   i = i+1;
   cd ../..
   
end