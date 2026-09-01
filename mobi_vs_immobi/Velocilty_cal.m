clear
path= 'E:\Videos Seizures without EEG)';
cd(path)
dlc_results = dir('**/*filtered.csv');
[~,idx,~] = natsort({dlc_results.name});
dlc_results = dlc_results(idx);

framerate  = [25 30 25];
size = [923 926; 1033 1045; 922 926];
maze_scale = [100./size(:,1) 100./size(:,2)]; % cm per pixel
cc = [14 17 14];

R_dlc = cell(1,length(dlc_results));
v = cell(1,length(dlc_results));
p = cell(1,length(dlc_results));
p_cm = cell(1,length(dlc_results));

v_thres = [2 1.75];

mobility_state = cell(1,length(dlc_results));
mobi_duration  = cell(1,length(dlc_results));
immobi_duration = cell(1,length(dlc_results));


for i = 1:length(dlc_results)
    R_dlc{i} = table2array(readtable(dlc_results(i).name));
    p{i} = R_dlc{i}(:,cc(i):cc(i)+1);   % body parts
    p_cm{i} = [p{i}(:,1)*maze_scale(i,1), p{i}(:,2)*maze_scale(i,2)]; % covert the location to cm
    v{i} = zeros(1,length(p_cm{i}));
    mobility_state{i} = zeros(1,length(p_cm{i}));
    mobi_duration{i} = [];
    immobi_duration{i} = [];
    t1=1; t2=1;v_flag = 0;
    for t = 2:length(p_cm{i})
        v{i}(t) = pdist2(p_cm{i}(t,:),p_cm{i}(t-1,:))*framerate(i);
        if v{i}(t)>=v_thres(2) & v{i}(t)<=v_thres(1)
            if v_flag==0
                mobility_state{i}(t) = 0;
            else 
                mobility_state{i}(t) = 1;
            end
        else if v{i}(t)>v_thres(1)
                mobility_state{i}(t) = 1;
                if v_flag == 0
                    v_flag = 1;
                    t2=t;
                    immobi_duration{i} = [immobi_duration{i}; t1,t2];
                end
        else if v{i}(t)<v_thres(2)
                mobility_state{i}(t) = 0;
                if v_flag ==1
                    v_flag = 0;
                    t1=t;
                    mobi_duration{i} = [mobi_duration{i}; t2,t1];
                end
        end
        end
        end
    end
    if v_flag == 0
        t2=t;
        immobi_duration{i} = [immobi_duration{i}; t1,t2];
    else if v_flag ==1
             t1=t;
            mobi_duration{i} = [mobi_duration{i}; t2,t1];
    end
    end

end
save('location_pixel','p')
save('location_cm','p_cm')
save('velocity','v')
save('mobility_state','mobility_state')
save('duration',"mobi_duration","immobi_duration")