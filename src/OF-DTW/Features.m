function [ ] = Features( )
% 显示OPEI,OPFI,周期，行、列运动矢量和
for i=1:1
    if i<10
        fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\00',int2str(i),'\nm-01\090\');
        BW1=OFReadpic(fileFolder{i});
    elseif i<100
         fileFolder{i} = strcat('E:\步态识别数据库\GaitDatasetB-silh\DatasetB\silhouettes\0',int2str(i),'\0',int2str(i),'\nm-01\090\');
         BW1=OFReadpic(fileFolder{i});
    else 
         fileFolder{i} = strcat('E:\步态识别数据库\GaitDatasetB-silh\DatasetB\silhouettes\',int2str(i),'\',int2str(i),'\nm-01\090\');
        BW1=OFReadpic(fileFolder{i});
    end    
%     OFHI(BW1);
    sum{i}=OFPeriod(BW1);
%     RowUs{i}=OFRowUsSymmetry(BW1);
%     RowVs{i}=OFRowVsSymmetry(BW1);
%     ColUs{i}=OFColUsSymmetry(BW1);
    ColVs{i}=OFColVsSymmetry(BW1);
end
% OFEI(BW1);
figure
for i=1:length(ColVs)
    hold on
%     plot(RowUs{i},'r-*');
%     plot(ColUs{i},'b-*');
%     plot(RowVs{i},'g-*');
%     plot(ColVs{i},'y-*');
     plot(sum{i},'r-*');
end

end

