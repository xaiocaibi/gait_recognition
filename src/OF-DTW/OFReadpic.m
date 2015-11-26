function [ BW ] = OFReadpic(fileFolder )
PicFile = dir(fullfile(strcat(fileFolder,'*.png')));
BW=cell(length(PicFile),1); 
for i=1:length(PicFile)
      I=imread(strcat(fileFolder,PicFile(i).name));
      BW{i}=Center(I); 
      BW{i}=imrotate(BW{i},180);
end
end

