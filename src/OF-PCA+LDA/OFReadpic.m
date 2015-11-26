function [ BW ] = OFReadpic(fileFolder )
%读取给定路径下的所有图片并完成中心归一化，旋转的过程

PicFile = dir(fullfile(strcat(fileFolder,'*.png')));
BW=cell(length(PicFile),1);

for i=1:length(PicFile)
      I=imread(strcat(fileFolder,PicFile(i).name));
      BW{i}=Center(I); 
      BW{i}=imrotate(BW{i},180);
end

end

