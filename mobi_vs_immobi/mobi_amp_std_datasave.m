clear
path = 'E:\Photometry_FP4_hsyn\DATA cage';
cd(path)
mobi_immobi = dir('**/*mobi_vs_immobi.mat');
Amp_sig = [];
STD_sig = [];
Amp_mobi = [];
STD_mobi = [];
Amp_immobi = [];
STD_immobi = [];
z_STD_mobi = [];
z_STD_immobi = [];
pilo = [1 2 3 4];
ctrl = [5 6 7];

for i = 1:length(mobi_immobi)
    load([mobi_immobi(i).folder,'/',mobi_immobi(i).name])
    Amp_sig = [Amp_sig,sig_amp];
    STD_sig = [STD_sig,sig_std];
    Amp_mobi = [Amp_mobi, avg_amp_mobi_all];
    STD_mobi = [STD_mobi, std_mobi_all];
    Amp_immobi = [Amp_immobi, avg_amp_immobi_all];
    STD_immobi = [STD_immobi, std_immobi_all];
    z_STD_mobi = [z_STD_mobi, z_std_mobi_all];
    z_STD_immobi = [z_STD_immobi, z_std_immobi_all];
end

Amp_sig_pilo = Amp_sig(pilo);
Amp_sig_ctrl = Amp_sig(ctrl);
save('Amp_sig',"Amp_sig_pilo","Amp_sig_ctrl")
STD_sig_pilo = STD_sig(pilo);
STD_sig_ctrl = STD_sig(ctrl);
save('STD_sig',"STD_sig_pilo","STD_sig_ctrl")
Amp_mobi_pilo = Amp_mobi(pilo);
Amp_mobi_ctrl = Amp_mobi(ctrl);
save('Amp_mobi',"Amp_mobi_pilo","Amp_mobi_ctrl")
STD_mobi_pilo = STD_mobi(pilo);
STD_mobi_ctrl = STD_mobi(ctrl);
save('STD_mobi',"STD_mobi_pilo","STD_mobi_ctrl")
Amp_immobi_pilo = Amp_immobi(pilo);
Amp_immobi_ctrl = Amp_immobi(ctrl);
save('Amp_immobi',"Amp_immobi_pilo","Amp_immobi_ctrl")
STD_immobi_pilo = STD_immobi(pilo);
STD_immobi_ctrl = STD_immobi(ctrl);
save('STD_immobi',"STD_immobi_pilo","STD_immobi_ctrl")
z_STD_mobi_pilo = z_STD_mobi(pilo);
z_STD_mobi_ctrl = z_STD_mobi(ctrl);
save('z_STD_mobi',"z_STD_mobi_pilo","z_STD_mobi_ctrl")
z_STD_immobi_pilo = z_STD_immobi(pilo);
z_STD_immobi_ctrl = z_STD_immobi(ctrl);
save('z_STD_immobi',"z_STD_immobi_pilo","z_STD_immobi_ctrl")