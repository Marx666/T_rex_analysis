%%Main script for Barnes exploration detection

clear; clc;
path = 'E:\analysistrajectories\ctrl suc';
cd(path)

namelist = dir('**/*.xlsx'); % DLC output files

B = cell(1,length(namelist));
for i = 1:length(namelist)
    B{i} = table2array(readtable(namelist(i).name));
end

save('xy','B')

target_visit;
direction_change;
target_explore;


