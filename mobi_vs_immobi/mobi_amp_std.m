clear
path = 'E:\Photometry_FP7_S5E2_Dlx\DATA Barnes PT\FP7';
cd(path)
files = dir('**/*corrected.mat');
[~,idx,~] = natsort({files.folder});
files = files(idx);

load([path,'\Videos\Analysis\Trim_time.mat'])
load([path,'\Videos\Analysis\mobility_state.mat'])
load([path,'\Videos\Analysis\duration.mat'])

avg_amp_mobi = cell(1,length(files));
avg_amp_immobi = cell(1,length(files));
std_mobi = cell(1,length(files));
std_immobi = cell(1,length(files));
for i =1:length(files)
    load([files(i).folder,'\',files(i).name])
    signal_corrected = interp(signal_corrected,3);
    sig = signal_corrected(Trim_time(i,1):Trim_time(i,2));
    sig_z = zscore(sig);
    sig_std(i) = std(sig);
    sig_amp(i) = mean(sig_z);
    for j = 1:size(mobi_duration{i},1)
        avg_amp_mobi{i}(j) = mean(sig_z(mobi_duration{i}(j,1):mobi_duration{i}(j,2)));
        std_mobi{i}(j) = std(sig(mobi_duration{i}(j,1):mobi_duration{i}(j,2)));
    end
    avg_amp_mobi_all(i) = mean(sig_z(mobility_state{i} == 1));
    std_mobi_all(i) = std(sig(mobility_state{i} == 1));
    z_std_mobi_all(i) = std(sig_z(mobility_state{i} == 1));
    for k = 1:size(immobi_duration{i},1)
        avg_amp_immobi{i}(k) = mean(sig_z(immobi_duration{i}(k,1):immobi_duration{i}(k,2)));
        std_immobi{i}(k) = std(sig(immobi_duration{i}(k,1):immobi_duration{i}(k,2)));
    end
    avg_amp_immobi_all(i) = mean(sig_z(mobility_state{i} == 0));
    std_immobi_all(i) = std(sig(mobility_state{i} == 0));
    z_std_immobi_all(i) = std(sig_z(mobility_state{i} == 0));
end

save([path,'\Videos\Analysis\mobi_vs_immobi.mat'],...
    "avg_amp_mobi","std_mobi","avg_amp_mobi_all","std_mobi_all",...
    "avg_amp_immobi","std_immobi","avg_amp_immobi_all","std_immobi_all",...
    "sig_std","sig_amp","z_std_mobi_all","z_std_immobi_all")
    

