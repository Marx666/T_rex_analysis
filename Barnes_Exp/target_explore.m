% clear
% load("xy.mat")
% load("ishole.mat")
% load("target.mat")
% load("angle_change.mat")
exp = cell(1,length(ishole));
ref = cell(1,length(ishole));
entry_count = zeros(length(ishole),20);
for i = 1:length(ishole)
    flag = 0; t1 = 0; t2 = 0;
    ref{i} = zeros(1,length(ishole{i}));
    for j = 1:length(ishole{i})
        if ~isequal(ishole{i}(j,:),zeros(1,20))
            switch flag
                case 0
                    flag = 1; t1 = j;
                case 1
                    if isequal(ishole{i}(j,:)-ishole{i}(t1,:),zeros(1,20))
                        t2 = j;
                    else
                        flag = 0; j = j-1;
                        if ~isempty(anglec{i}(t1:t2))
                            if sum(or(anglec{i}(t1:t2)>90,anglec{i}(t1:t2)<-90))>0
                                exp{i}(end+1) = {anglec{i}(t1:t2)};
                                entry_count(i,:) = entry_count(i,:)+ishole{i}(t1,:);
                                ref{i}(t1:t2) = 1;
                            end
                        end
                    end
            end
        end   
    end
if ~isempty(anglec{i}(t1:t2))
    if sum(or(anglec{i}(t1:t2)>90,anglec{i}(t1:t2)<-90))>0
        exp{i}(end+1) = {anglec{i}(t1:t2)};
        entry_count(i,:) = entry_count(i,:)+ishole{i}(t1,:);
        ref{i}(t1:t2) = 1;
    end
end
end

% figure
% bar(mean(entry_count))
% hold on
% errorbar(mean(entry_count),sem(entry_count,1))

save('exploration','exp')
save('entry_count','entry_count')