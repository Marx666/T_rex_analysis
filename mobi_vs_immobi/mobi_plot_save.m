clear
path = 'F:\DATA cage';
cd(path)
f = dir('**/*mobi_sig.fig');

for i = 1:length(f)
    open([f(i).folder,'/',f(i).name])
    exportgraphics(gcf,[f(i).folder,'/',f(i).name,'.eps'],'Resolution',300)
    exportgraphics(gcf,[f(i).folder,'/',f(i).name,'.png'],'Resolution',300)
    close
end


