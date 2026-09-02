%%Calculate the area of hippocampus from marks exported from imageJ

clc;clear;
path = 'E:\Images czi et jpg\e-PILO CNO';
cd([path,'\CA1'])

namelist = dir('**/*.txt');
[~,inx] = natsort({namelist.name});
namelist = namelist(inx);
HP = cell(1,length(namelist));
HPa = zeros(1,length(namelist));
for i = 1:length(namelist)
    HP{i} = table2array(readtable([namelist(i).folder,'\',namelist(i).name]));
    HPa(i) = polyarea(HP{i}(:,1),HP{i}(:,2));
end
HPa = HPa*(1.38^2)/(10^6);
save([path,'\CA1xy'],'HP')
save([path,'\CA1a'],'HPa')
xlswrite([path,'\CA1 Area'],HPa)


clc;clear;
path = 'E:\Images czi et jpg\e-PILO CNO';
cd([path,'\hippo'])

namelist = dir('**/*.txt');
[~,inx] = natsort({namelist.name});
namelist = namelist(inx);
HP = cell(1,length(namelist));
HPa = zeros(1,length(namelist));
for i = 1:length(namelist)
    HP{i} = table2array(readtable([namelist(i).folder,'\',namelist(i).name]));
    HPa(i) = polyarea(HP{i}(:,1),HP{i}(:,2));
end
HPa = HPa*(1.38^2)/(10^6);
save([path,'\hippoxy'],'HP')
save([path,'\hippoa'],'HPa')
xlswrite([path,'\HP Area'],HPa)
