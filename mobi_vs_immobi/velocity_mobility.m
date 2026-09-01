function [v, mobi_state, mobi_duration, immobi_duration] = velocity_mobility(position, mobi_start, mobi_end, framerate)

v = zeros(1, length(position));
mobi_state = zeros(1, length(position));
mobi_duration  = [];
immobi_duration = [];
t1 = 1; t2 =1;
v_flag = 0;

for t = 2:length(position)
    v(t) = pdist2(position(t,:),position(t-1,:))*framerate;
    if v(t)>=mobi_end & v(t)<=mobi_start
        if v_flag==0
            mobi_state(t) = 0;
        else 
            mobi_state(t) = 1;
        end
    else if v(t)>mobi_start
            mobi_state(t) = 1;
            if v_flag == 0
                v_flag = 1;
                t2=t;
                immobi_duration = [immobi_duration; t1,t2];
            end
    else if v(t)<mobi_end
            mobi_state(t) = 0;
            if v_flag ==1
                v_flag = 0;
                t1=t;
                mobi_duration = [mobi_duration; t2,t1];
            end
    end
    end
    end
end

return