function [Trim_time] = trim_video(filepath, startFrame, endFrame, Height1, Height2, Width1, Width2)

input_v = VideoReader(filepath);
if endFrame == 0
    nFrames = input_v.NumFrames;
else 
    nFrames = endFrame;
end
output_v = VideoWriter([filepath(1:end-4),'_trimmed'],'MPEG-4');
output_v.FrameRate = 25;
% endFrame = 0;
open(output_v)
for j = startFrame:nFrames
    try
        vframe = read(input_v, j);
        if and(Height1<Height2,Width1<Width2)
            vframe = vframe(Height1:Height2,Width1:Width2,:);
        end
        writeVideo(output_v, vframe)
    catch
        endFrame = j-1;
    end
end
if endFrame == 0
    endFrame = j;
end
close(output_v)

Trim_time = [startFrame', endFrame'];
save([filepath(1:end-4),'_Trim_time'],'Trim_time')
imwrite(vframe,'ref.jpg')

return