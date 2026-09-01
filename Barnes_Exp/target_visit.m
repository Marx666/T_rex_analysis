% clear
% load('xy.mat')
Bd = cell(1,length(B));
ishole = Bd;
target = zeros(length(B),20);
holexy = table2array(readtable('holexy.txt'));
for i = 1:length(B)
    B{i} = fillmissing(B{i},'linear');
    Bd{i} = pdist2(B{i}(:,5:6),holexy(:,2:3));
    Bd{i} = single((Bd{i}<4.5));
    ishole{i} = Bd{i};
    Bd{i}(2:end) = Bd{i}(2:end)-Bd{i}(1:end-1);
    Bd{i}(sum(Bd{i},2)<=0,:) = [];

    Bd{i}(2:end) = Bd{i}(2:end)-Bd{i}(1:end-1);
    Bd{i}(Bd{i}==-1)=0;
    Bd{i}(sum(Bd{i},2)<=0,:) = [];
    target(i,:) = sum(Bd{i});
end

% figure
% bar(mean(target))
% hold on
% errorbar(mean(target),sem(target,1))

save('ishole','ishole')
save('target','target')