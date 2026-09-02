%%Generate a video displaying the Barnes footage and the angle change curve together.

videolist = dir('**/*.mpg');

trialnum = 10;

%%open the drone vid 
inputVid = VideoReader([videolist(trialnum).folder,'/',videolist(trialnum).name]);
TotnumFrames = inputVid.FrameRate*inputVid.Duration;
dataw = [zeros(1,TotnumFrames-length(anglec{trialnum})),anglec{trialnum}];
refw = [zeros(1,TotnumFrames-length(anglec{trialnum})),ref{trialnum}];
mergedobj = VideoWriter(['trial',num2str(trialnum)],'Motion JPEG AVI');
mergedobj.FrameRate = inputVid.FrameRate;
mergedobj.Quality=100;
open(mergedobj); 

%start the stitch
hfig = figure;
k = 1;
%while loop until there are no more frames
while hasFrame(inputVid)
    %read in frame
    singleFrame = readFrame(inputVid);   
    % display frame
    subplot(6,4,1:16)
    imshow(singleFrame)
    subplot(6,4,17:24)
    ylim([-180 180])
    yticks([-180 -90 0 90 180])
    switch refw(k)
        case 0
            plot(k,dataw(k),'.','Color','b'),hold on;
            plot(k,-90,'_','Color','k'),hold on;
            plot(k,90,'_','Color','k'),hold on;
        case 1
            plot(k,dataw(k),'.','Color','r'),hold on;
            plot(k,-90,'_','Color','k'),hold on;
            plot(k,90,'_','Color','k'),hold on;
    end
    g = gcf;
    g.WindowState = 'maximized';
    %grab what the figure looks like
    frame = getframe(hfig);
    %write to file.
    writeVideo(mergedobj, frame);
    k = k+1;
end
%close the object
close(mergedobj)
