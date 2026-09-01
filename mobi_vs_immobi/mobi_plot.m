clear
path = 'E:\Photometry_FP7_S5E2_Dlx\DATA cage\FP7';
cd(path)
files = dir('**/*corrected.mat');
[~,idx,~] = natsort({files.folder});
files = files(idx);

load([path,'\Videos\Analysis\Trim_time.mat'])
load([path,'\Videos\Analysis\mobility_state.mat'])
load([path,'\Videos\Analysis\duration.mat'])

for i = 1:length(files)
    load([files(i).folder,'\',files(i).name])
    signal_corrected = interp(signal_corrected,3);
    sig = signal_corrected(Trim_time(i,1):Trim_time(i,2));
    sig_z = zscore(sig);
    figure
    plot(sig_z)
    xlim([1 Trim_time(i,2)-Trim_time(i,1)+1])
    scrollplot;
    hold on
    yyaxis right
    scatter([1:1:length(mobility_state{i})],mobility_state{i},'.')
    ylim([-0.1 1.1])
    set(gcf, 'Position', [100 100 2000 400])
    savefig(gcf, [files(i).folder,'\mobi_sig'])
    exportgraphics(gcf,[files(i).folder,'\mobi_sig.png'],'Resolution',300)
    close
end