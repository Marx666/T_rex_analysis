%% Calculate the angle change of the animal body vector between two frames 

anglec = cell(1,length(B));
Vec = cell(1,length(B));

for i = 1:length(B)
    for j = 2:length(B{i})
        Vec{i}(j,:) = [B{i}(j,5:6)-B{i}(j-1,5:6),0]; % define the body vector
    end
end

p = [0 0 1]; % Normal vector
for i = 1:length(Vec)
    for j = 3:length(Vec{i})
        anglec{i}(j) = vecangle360(Vec{i}(j,:),Vec{i}(j-1,:),p); % angle change
    end
end

save('angle_change','anglec')
