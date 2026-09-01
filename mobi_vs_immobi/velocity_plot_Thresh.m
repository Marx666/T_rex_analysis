clear
path = 'E:\Photometry_FP7_S5E2_Dlx\DATA Barnes PT';
cd(path)
files = dir('**/*corrected.mat');
[~,idx,~] = natsort({files.folder});
files = files(idx);

% pilo = [1 2 10 12 13 14 19 20 21 22];
% ctrl = [3 4 5 6 7 8 9 15 16 17]; % FP1-3 PT
% pilo = [5 6 7 8 9 13 14 15 16 17];
% ctrl = [1 2 3 4 10 11 12]; % FP1-3 Cage
% pilo = [1 2 3 4];
% ctrl = [5 6 7]; % FP4
% pilo = [1 2 3 4 5];
% ctrl = [6 7 8 9 10]; % FP5
% pilo_pv = [3 4 5 6 7 8];
% ctrl = [1 2];
% pilo_h = [9 10 11 12 13 14]; %FP6
pilo = [1 2 3 4 5 6];
ctrl = [7 8 9 10 11];

sample_width = 30;  %% 1s
overlap = 10;
Thresh = 1;
load([path,'\Trim_time.mat'])
load([path,'\v_all.mat'])
load([path,'\v_amp_windowed.mat'])
for i =1:length(files) 
    if ismember(i,[pilo,ctrl])
        load([files(i).folder,'\',files(i).name])
        % signal_corrected = interp(signal_corrected,3);
        sig = signal_corrected(Trim_time(i,1):Trim_time(i,2));
        sig_z = zscore(sig);
    
        lmin = min(length(sig_z), length(v_all{i}));
        if length(sig_z) ~= length(v_all{i})
            sig_z = sig_z(1:lmin);
            v_all{i} = v_all{i}(1:lmin);
        end
        % mean_amp{i} = [];
        % mean_v{i} = [];
        % w =1+sample_width/2;
        % while w+sample_width/2<=min([length(sig_z),length(v_all{i})])
        %     mean_amp{i} = [mean_amp{i},mean(sig_z(w-sample_width/2:w+sample_width/2))];
        %     mean_v{i} = [mean_v{i},mean(v_all{i}(w-sample_width/2:w+sample_width/2))];
        %     w = w+overlap;
        % end
        inx = find(mean_v{i}>Thresh);
        if ~isempty(inx)
            mean_v_mobi{i} = mean_v{i}(inx);
            mean_amp_mobi{i} = mean_amp{i}(inx);
        
            figure
            set(gcf, 'Position', [100 100 900 900])
            subplot(5,1,1)
            plot(sig_z)
            xlabel off
            xlim([1 length(sig_z)])
            ylim([min(cell2mat(mean_amp),[],'all') max(cell2mat(mean_amp),[],'all')])
            ylabel('z-score')
            subplot(5,1,2)
            plot(v_all{i})
            xlabel('Frame')
            xlim([1 length(v_all{i})])
            ylim([min(cell2mat(mean_v),[],'all') max(cell2mat(mean_v),[],'all')])
            ylabel('Velocity (cm/s)')
            subplot(5,1,[3 4 5])
            mdl = fitlm(mean_v_mobi{i}, mean_amp_mobi{i})
            [R{i},P{i}] = corrcoef(mean_v_mobi{i}, mean_amp_mobi{i});
            plot(mdl)
            xlabel('Velocity (cm/s)')
            ylabel('z-score')
            legend off
            xlim([min(cell2mat(mean_v),[],'all') max(cell2mat(mean_v),[],'all')])
            ylim([min(cell2mat(mean_amp),[],'all') max(cell2mat(mean_amp),[],'all')])

            savefig(gcf, [files(i).folder,'\v_fig_above_thresh.fig'])
            exportgraphics(gcf,[files(i).folder,'\v_fig_above_thresh.png'],'Resolution',300)
            save([files(i).folder,'\v_info_above_thresh',],"mdl")
            close
        end
    end
end
amp_pool_all = cat(2,mean_amp_mobi{:});
v_pool_all = cat(2,mean_v_mobi{:});
amp_pool_pilo = cat(2,mean_amp_mobi{pilo});
v_pool_pilo = cat(2,mean_v_mobi{pilo});
amp_pool_ctrl = cat(2,mean_amp_mobi{ctrl});
v_pool_ctrl = cat(2,mean_v_mobi{ctrl});
mdl_pool_all = fitlm(v_pool_all,amp_pool_all)
[R_pool_all,P_pool_all] = corrcoef(v_pool_all,amp_pool_all);
mdl_pool_pilo = fitlm(v_pool_pilo,amp_pool_pilo)
[R_pool_pilo,P_pool_pilo] = corrcoef(v_pool_pilo,amp_pool_pilo);
mdl_pool_ctrl = fitlm(v_pool_ctrl,amp_pool_ctrl)
[R_pool_ctrl,P_pool_ctrl] = corrcoef(v_pool_ctrl,amp_pool_ctrl);
figure
set(gcf, 'Position', [100 100 900 900])
plot(mdl_pool_all)
xlabel('Velocity (cm/s)')
ylabel('z-score')
legend off
xlim([min(cell2mat(mean_v),[],'all') max(cell2mat(mean_v),[],'all')])
ylim([min(cell2mat(mean_amp),[],'all') max(cell2mat(mean_amp),[],'all')])
savefig(gcf, [path,'\v_fig_all_animal_above_thresh.fig'])
exportgraphics(gcf,[path,'\v_fig_all_animal_above_thresh.png'],'Resolution',300)
save([path,'\v_info_all_animal_above_thresh'],'mdl_pool_all')
close
figure
set(gcf, 'Position', [100 100 900 900])
plot(mdl_pool_pilo)
xlabel('Velocity (cm/s)')
ylabel('z-score')
legend off
xlim([min(cell2mat(mean_v),[],'all') max(cell2mat(mean_v),[],'all')])
ylim([min(cell2mat(mean_amp),[],'all') max(cell2mat(mean_amp),[],'all')])
savefig(gcf, [path,'\v_fig_all_pilo_above_thresh.fig'])
exportgraphics(gcf,[path,'\v_fig_all_pilo_above_thresh.png'],'Resolution',300)
save([path,'\v_info_all_pilo_above_thresh'],'mdl_pool_pilo')
close
figure
set(gcf, 'Position', [100 100 900 900])
plot(mdl_pool_ctrl)
xlabel('Velocity (cm/s)')
ylabel('z-score')
legend off
xlim([min(cell2mat(mean_v),[],'all') max(cell2mat(mean_v),[],'all')])
ylim([min(cell2mat(mean_amp),[],'all') max(cell2mat(mean_amp),[],'all')])
savefig(gcf, [path,'\v_fig_all_ctrl_above_thresh.fig'])
exportgraphics(gcf,[path,'\v_fig_all_ctrl_above_thresh.png'],'Resolution',300)
save([path,'\v_info_all_ctrl_above_thresh'],'mdl_pool_ctrl')
close

% save([path,'\v_amp_windowed'],"mean_v","mean_amp")
save([path,'\Coef_v_amp_above_thresh'],"R","P","R_pool_pilo","R_pool_ctrl",...
    "R_pool_all","P_pool_pilo","P_pool_ctrl","P_pool_all")