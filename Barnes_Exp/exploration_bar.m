for i=1:5
    M(i,:) = mean(regroup{i});
    STD(i,:) = std(regroup{i});
    SEM(i,:) = sem(regroup{i},1);
end
b = bar(M');
hold on
[ngroups,nbars] = size(M');
% Get the x coordinate of the bars
x = nan(nbars, ngroups);
for i = 1:nbars
    x(i,:) = b(i).XEndPoints;
end
% Plot the errorbars
errorbar(x',M',SEM','k','linestyle','none');