clear
path = 'E:\Photometry_FP0_FP3\DATA cage';
load([path,'\v_amp_windowed.mat'])

% pilo = [1 2 10 12 13 14 19 20 21 22];
% ctrl = [3 4 5 6 7 8 9 15 16 17];
% namespace = {'CD1-949','CD1-950','CD1-951','CD1-952','CD1-953','CD1-960','CD1-961','CD1-963','CD1-964',...
%     'CD1-965','CD1-966','CD1-967','CD1-973','CD1-974','CD1-985','CD1-986','CD1-987','CD1-991','CD1-995',...
%     'CD1-1000','CD1-1002','CD1-1003'};
pilo = [5 6 7 8 9 13 14 15 16 17];
ctrl = [1 2 3 4 10 11 12];
namespace = {'CD1-960','CD1-961','CD1-963','CD1-964','CD1-965','CD1-966','CD1-967','CD1-973',...
    'CD1-974','CD1-985','CD1-986','CD1-987','CD1-991','CD1-995','CD1-1000','CD1-1002','CD1-1003'};
for i= 1:length(mean_v)
    if ~isempty(mean_v{i})
        counts{i} = zeros(1,ceil(max(cell2mat(mean_v),[],'all')));
        for n = 1:length(mean_v{i})
            counts{i}(ceil(mean_v{i}(n))) = counts{i}(ceil(mean_v{i}(n)))+1;
        end
        % counts{i}(1) = [];
        f{i} = counts{i}/sum(counts{i});
        fc{i} = cumsum(f{i});
        if sum(~isnan(f{i}))~=0
            figure
            histogram('BinEdges',0:1:ceil(max(cell2mat(mean_v),[],'all')),'BinCounts',f{i})
            xlabel('Velocity')
            xlim([0 87])
            ylim([0 1])
            yyaxis right
            plot(fc{i})
            ylabel('Frequency',"Rotation",-90)
            ylim([0 1.1])
            savefig(gcf,[path,'\Figures\Velocity_distribution\',namespace{i},'.fig'])
            exportgraphics(gcf,[path,'\Figures\Velocity_distribution\',namespace{i},'.png'],'Resolution',300)
            close
        end
    end
end
% save([path,'\Figures\Velocity_distribution\Velocity_distribution.mat'],"counts")

v_pool_all = cat(2,mean_v{:});
counts_all = zeros(1,ceil(max(cell2mat(mean_v),[],'all')));
for n = 1:length(v_pool_all)
    counts_all(ceil(v_pool_all(n))) = counts_all(ceil(v_pool_all(n)))+1;
end
% counts_all(1) = [];
f_all = counts_all/sum(counts_all);
fc_all = cumsum(f_all);
figure
histogram('BinEdges',0:1:ceil(max(cell2mat(mean_v),[],'all')),'BinCounts',f_all)
xlabel('Velocity')
xlim([0 87])
ylim([0 1])
yyaxis right
plot(fc_all)
ylabel('Frequency',"Rotation",-90)
ylim([0 1.1])
savefig(gcf,[path,'\Figures\Velocity_distribution\all.fig'])
exportgraphics(gcf,[path,'\Figures\Velocity_distribution\all.png'],'Resolution',300)
close

v_pool_pilo = cat(2,mean_v{pilo});
counts_pilo = zeros(1,ceil(max(cell2mat(mean_v),[],'all')));
for n = 1:length(v_pool_pilo)
    counts_pilo(ceil(v_pool_pilo(n))) = counts_pilo(ceil(v_pool_pilo(n)))+1;
end
% counts_pilo(1) = [];
f_pilo = counts_pilo/sum(counts_pilo);
fc_pilo = cumsum(f_pilo);
figure
histogram('BinEdges',0:1:ceil(max(cell2mat(mean_v),[],'all')),'BinCounts',f_pilo)
xlabel('Velocity')
xlim([0 87])
ylim([0 1])
yyaxis right
plot(fc_pilo)
ylabel('Frequency',"Rotation",-90)
ylim([0 1.1])
savefig(gcf,[path,'\Figures\Velocity_distribution\pilo.fig'])
exportgraphics(gcf,[path,'\Figures\Velocity_distribution\pilo.png'],'Resolution',300)
close

v_pool_ctrl = cat(2,mean_v{ctrl});
counts_ctrl = zeros(1,ceil(max(cell2mat(mean_v),[],'all')));
for n = 1:length(v_pool_ctrl)
    counts_ctrl(ceil(v_pool_ctrl(n))) = counts_ctrl(ceil(v_pool_ctrl(n)))+1;
end
% counts_ctrl(1) = [];
f_ctrl = counts_ctrl/sum(counts_ctrl);
fc_ctrl = cumsum(f_ctrl);
figure
histogram('BinEdges',0:1:ceil(max(cell2mat(mean_v),[],'all')),'BinCounts',f_ctrl)
xlabel('Velocity')
xlim([0 87])
ylim([0 1])
yyaxis right
plot(fc_ctrl)
ylabel('Frequency',"Rotation",-90)
ylim([0 1.1])
savefig(gcf,[path,'\Figures\Velocity_distribution\ctrl.fig'])
exportgraphics(gcf,[path,'\Figures\Velocity_distribution\ctrl.png'],'Resolution',300)
close
% save([path,'\Figures\Velocity_distribution\Velocity_distribution_pool.mat'],...
%     "counts_all","counts_pilo","counts_ctrl")