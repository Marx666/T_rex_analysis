path  = 'E:\Photometry_FP7_S5E2_Dlx\DATA cage';
cd(path)
video_files = dir('**/*.mp4');

startFrame = ones(1,length(video_files));
endFrame = zeros(1,length(video_files));
for i = 1:length(video_files)
    Vpath = [video_files(i).folder,'\',video_files(i).name];
    input_v = VideoReader(Vpath);
    nFrames = input_v.NumFrames;
    output_v = VideoWriter([Vpath,'_trimmed'],'MPEG-4');
    open(output_v)
    for j = startFrame(i):nFrames
        try
            vframe = read(input_v, j);
            vframe = vframe(401:1080,421:1420,:);
            writeVideo(output_v, vframe)
        catch
            endFrame(i) = j-1;
        end
    end
    if endFrame(i) == 0
        endFrame(i) = j;
    end
    close(output_v)
end
Trim_time = [startFrame',endFrame'];
save([video_files(i).folder,'\Trim_time.mat'],'Trim_time')
imwrite(vframe,[video_files(i).folder,'\ref.jpg'])

