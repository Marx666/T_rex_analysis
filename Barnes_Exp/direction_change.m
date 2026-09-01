% clear
% load("xy.mat")
% load("ishole.mat")
% load("target.mat")
anglec = cell(1,length(B));
Vec = cell(1,length(B));
% for i = 1:length(B)
%     Vec{i} = [B{i}(:,5:6)-B{i}(:,3:4),zeros(length(B{i}),1)];
% end

for i = 1:length(B)
    for j = 2:length(B{i})
        Vec{i}(j,:) = [B{i}(j,5:6)-B{i}(j-1,5:6),0];
    end
end

p = [0 0 1];
for i = 1:length(Vec)
    for j = 3:length(Vec{i})
        anglec{i}(j) = vecangle360(Vec{i}(j,:),Vec{i}(j-1,:),p);
    end
    % figure
    % scatter3(B{i}(sum(ishole{i},2)==0,5),B{i}(sum(ishole{i},2)==0,6),anglec{i}(sum(ishole{i},2)==0),'Color','b')
    % hold on
    % scatter3(B{i}(sum(ishole{i},2)==1,5),B{i}(sum(ishole{i},2)==1,6),anglec{i}(sum(ishole{i},2)==1),'Color','r')
end

save('angle_change','anglec')
