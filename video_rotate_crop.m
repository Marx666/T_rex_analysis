%%Rotate a video then crop it

Vpath = 'E:\Photometry_FP7_S5E2_Dlx\Home cage videos\20260106 FP7 home cage\Videos\CD1 1210 1208.mp4';
input_v = VideoReader(Vpath);
nFrames = input_v.NumFrames;
output_v1 = VideoWriter([Vpath(1:end-4),'_1'],'MPEG-4');
output_v2 = VideoWriter([Vpath(1:end-4),'_2'],'MPEG-4');
open(output_v1)
open(output_v2)
for j = 1:nFrames
    try
        vframe = read(input_v, j);
        vframe = imrotate(vframe,-45); % set angle
        vframe_1 = vframe(171:620,241:490,1:3); % crop
        vframe_2 = vframe(361:800,481:750,1:3); % crop
        writeVideo(output_v1, vframe_1)
        writeVideo(output_v2, vframe_2)
    catch
    end
end
close(output_v1)
close(output_v2)

