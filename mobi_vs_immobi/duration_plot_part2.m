figure
inx = find(pilo_mobi_mix(4,:)>=30);
mdl = fitlm(pilo_mobi_mix(4,inx),pilo_mobi_mix(3,inx))
anova(mdl,'summary')
plot(mdl)

figure
inx = find(pilo_immobi_mix(4,:)>=30);
mdl = fitlm(pilo_immobi_mix(4,inx),pilo_immobi_mix(3,inx))
anova(mdl,'summary')
plot(mdl)

figure
inx = find(ctrl_mobi_mix(4,:)>=30);
mdl = fitlm(ctrl_mobi_mix(4,inx),ctrl_mobi_mix(3,inx))
anova(mdl,'summary')
plot(mdl)

figure
inx = find(ctrl_immobi_mix(4,:)>=30);
mdl = fitlm(ctrl_immobi_mix(4,inx),ctrl_immobi_mix(3,inx))
anova(mdl,'summary')
plot(mdl)