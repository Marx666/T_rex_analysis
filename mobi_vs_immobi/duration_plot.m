clear
path = 'E:\Photometry\DATA cage';
cd(path)
files = dir('**/*corrected.mat');
[~,idx,~] = natsort({files.folder});
files = files(idx);

% pilo = [1 2 10 11 12 13 14 18 19 20 21 22];
% ctrl = [3 4 5 6 7 8 9 15 16 17];
pilo = [5 6 7 8 9 13 14 15 16 17];
ctrl = [1 2 3 4 10 11 12];

load([path,'\Trim_time.mat'])
load([path,'\duration_all.mat'])

for i =1:length(files)
    load([files(i).folder,'\',files(i).name])
    sig = signal_corrected(Trim_time(i,1):Trim_time(i,2));
    sig_z = zscore(sig);
    for j = 1:length(mobi_duration_all{i})
        amp_mobi{i}(j) = mean(sig_z(mobi_duration_all{i}(j,1):mobi_duration_all{i}(j,2)));
        STD_mobi{i}(j) = std(sig(mobi_duration_all{i}(j,1):mobi_duration_all{i}(j,2)));
        z_STD_mobi{i}(j) = std(sig_z(mobi_duration_all{i}(j,1):mobi_duration_all{i}(j,2)));
    end
    for k = 1:length(immobi_duration_all{i})
        amp_immobi{i}(k) = mean(sig_z(immobi_duration_all{i}(k,1):immobi_duration_all{i}(k,2)));
        STD_immobi{i}(k) = std(sig(immobi_duration_all{i}(k,1):immobi_duration_all{i}(k,2)));
        z_STD_immobi{i}(k) = std(sig_z(immobi_duration_all{i}(k,1):immobi_duration_all{i}(k,2)));
    end
end

pilo_mobi_mix(1,:) = cat(2,amp_mobi{pilo});
pilo_immobi_mix(1,:) = cat(2,amp_immobi{pilo});
pilo_mobi_mix(2,:) = cat(2,STD_mobi{pilo});
pilo_immobi_mix(2,:) = cat(2,STD_immobi{pilo});
pilo_mobi_mix(3,:) = cat(2,z_STD_mobi{pilo});
pilo_immobi_mix(3,:) = cat(2,z_STD_immobi{pilo});

dur_pilo_mobi = cat(1,mobi_duration_all{pilo});
pilo_mobi_mix(4,:) = (dur_pilo_mobi(:,2)-dur_pilo_mobi(:,1))';
dur_pilo_immobi = cat(1,immobi_duration_all{pilo});
pilo_immobi_mix(4,:) = (dur_pilo_immobi(:,2)-dur_pilo_immobi(:,1))';

ctrl_mobi_mix(1,:) = cat(2,amp_mobi{ctrl});
ctrl_immobi_mix(1,:) = cat(2,amp_immobi{ctrl});
ctrl_mobi_mix(2,:) = cat(2,STD_mobi{ctrl});
ctrl_immobi_mix(2,:) = cat(2,STD_immobi{ctrl});
ctrl_mobi_mix(3,:) = cat(2,z_STD_mobi{ctrl});
ctrl_immobi_mix(3,:) = cat(2,z_STD_immobi{ctrl});

dur_ctrl_mobi = cat(1,mobi_duration_all{ctrl});
ctrl_mobi_mix(4,:) = (dur_ctrl_mobi(:,2)-dur_ctrl_mobi(:,1))';
dur_ctrl_immobi = cat(1,immobi_duration_all{ctrl});
ctrl_immobi_mix(4,:) = (dur_ctrl_immobi(:,2)-dur_ctrl_immobi(:,1))';