path = 'E:\Videos Seizures without EEG)';
cd(path)
files = dir('**/*Velocity.mat');

sample_width = 30;  %% 1s
overlap = 10;

for f = 1:length(files)
    load([files(f).folder,'\',files(f).name])
    for i = 1:length(v)
        mean_v{i} = [];
        w =1+sample_width/2;
        while w+sample_width/2<=length(v{i})
            mean_v{i} = [mean_v{i},mean(v{i}(w-sample_width/2:w+sample_width/2))];
            w = w+overlap;
        end
    end
    save([files(f).folder,'\mean_v.mat'],"mean_v")
    clear mean_v
end