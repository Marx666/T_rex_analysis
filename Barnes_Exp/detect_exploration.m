function [anglec, hole_order, exp_range, entry_count, ref] = detect_exploration(xy, ishole)
for i = 2:length(xy)
        Vec(i,:) = [xy(i,:)-xy(i-1,:),0];
end

p = [0 0 1];

for j = 3:length(Vec)
    anglec(j) = vecangle360(Vec(j,:),Vec(j-1,:),p);
end

entry_count = zeros(1,20);
hole_order = [];
exp_range = [];

flag = 0; t1 = 0; t2 = 0;
ref = zeros(1,length(ishole));
for k = 1:length(ishole)
    if ~isequal(ishole(k,:),zeros(1,20))
        switch flag
            case 0
                flag = 1; t1 = k;
            case 1
                if isequal(ishole(k,:)-ishole(t1,:),zeros(1,20))
                    t2 = k;
                else
                    flag = 0; k = k-1;
                    if ~isempty(anglec(t1:t2))
                        if sum(or(anglec(t1:t2)>90,anglec(t1:t2)<-90))>0
                            entry_count = entry_count+ishole(t1,:);
                            hole_order(end+1) = find(ishole(t1,:));
                            exp_range = [exp_range; t1,t2];
                            ref(t1:t2) = 1;
                        end
                    end
                end
        end
    end   
end
if ~isempty(anglec(t1:t2))
    if sum(or(anglec(t1:t2)>90,anglec(t1:t2)<-90))>0
        entry_count = entry_count+ishole(t1,:);
        hole_order(end+1) = find(ishole(t1,:));
        exp_range = [exp_range; t1,t2];
        ref(t1:t2) = 1;
    end
end