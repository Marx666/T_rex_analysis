pilo = [1 2 3 4 5 6 21 22 23 24 25 26 27 28 29 30 37 38 39 40 41 42 43 44 45 46];
ctrl = [7 8 9 10 11 12 13 14 15 16 17 18 19 20 31 32 33 34 35 36];

sample_width = 30;  %% 1s
overlap = 10;

for i = 1:length(v)
    mean_v{i} = [];
    w =1+sample_width/2;

    while w+sample_width/2<=length(v{i})
        mean_v{i} = [mean_v{i},mean(v{i}(w-sample_width/2:w+sample_width/2))];
        w = w+overlap;
    end
end

mean_v_pilo = [mean_v{pilo}];
mean_v_ctrl = [mean_v{ctrl}];

cellfun(@max, mean_v, 'UniformOutput', false)