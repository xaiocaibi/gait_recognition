function [  ] = OFMain(  )
%数据库
m=5;%m表示样本数量fds

for i=1:m
    %建立模板，求出同一个人在不同状态下行或者列的方向矢量和
    for j=1:3
        if i<10
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\00',int2str(i),'\nm-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});%BW1表示个体i在条件j下的图像序列
        elseif i<100
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\0',int2str(i),'\nm-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});
        else 
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\',int2str(i),'\nm-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});
        end
        [RowUs{j},RowVs{j},ColUs{j},ColVs{j}]=OFSymmetry(BW1);%RowUs{j}表示个体i在条件j下行的左右运动矢量和向量，RowUs中每个元胞向量维度不一
    end
    
    [RowUsMatrix{i},RowVsMatrix{i},ColUsMatrix{i},ColVsMatrix{i}] = EigVector(RowUs,RowVs,ColUs,ColVs);%RowUsMatrix{i}每个元胞表示个体{i}在不同情况下的RowUs形成的特征矩阵
                                                                                   %RowUsMatrix的每个元胞矩阵维度不一
end

    %PCA空间,ProjectRU表示RowUs空间的投影矩阵，sRowUs表示数据库样本投影后的坐标
    [ProjectRU,sRowUs,ProjectRV,sRowVs,ProjectCU,sColUs,ProjectCV,sColVs]=PcaPlusLda(RowUsMatrix,RowVsMatrix,ColUsMatrix,ColVsMatrix);
 
 
%测试样本
for i=1:m
    %建立模板，求出同一个人在不同状态下行或者列的方向矢量和
    for j=1:2
        if i<10
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\00',int2str(i),'\cl-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});%BW1表示个体i在条件j下的图像序列
        elseif i<100
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\0',int2str(i),'\cl-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});
        else 
               fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\',int2str(i),'\cl-0',int2str(j),'\090\');
               BW1=OFReadpic(fileFolder{i});
        end
        [RowUs0{j},RowVs0{j},ColUs0{j},ColVs0{j}]=OFSymmetry(BW1);
    end
    %测试样本的四个特征值提取过程,
    [RowUsMatrix0{i},RowVsMatrix0{i},ColUsMatrix0{i},ColVsMatrix0{i}] = EigVector(RowUs0,RowVs0,ColUs0,ColVs0);
end
    
    %对不同个体特征矩阵维度校正后求平均值

    [RowUsVector,RowVsVector,ColUsVector,ColVsVector ] = CellAlignToAverageVector( RowUsMatrix0,RowVsMatrix0,ColUsMatrix0,ColVsMatrix0);
    
    %和数据库样本维度规整
    RowUsVector(:,size(ProjectRU,2)+1)=0;
    RowVsVector(:,size(ProjectRV,2)+1)=0;
    ColUsVector(:,size(ProjectCU,2)+1)=0;
    ColVsVector(:,size(ProjectCV,2)+1)=0;
    for i=1:size(ProjectRU,2)
        RowUsVector0(:,i)=RowUsVector(:,i);
    end
    for i=1:size(ProjectRV,2)
        RowVsVector0(:,i)=RowVsVector(:,i);
    end
    for i=1:size(ProjectCU,2)
        ColUsVector0(:,i)=ColUsVector(:,i);
    end
    for i=1:size(ProjectCV,2)
        ColVsVector0(:,i)=ColVsVector(:,i);
    end
    
%识别过程
     sRowUs0=ProjectRU*RowUsVector0';%样本投影
     sRowVs0=ProjectRV*RowVsVector0';
     sColUs0=ProjectCU*ColUsVector0';
     sColVs0=ProjectCV*ColVsVector0';
     [ r1,r2,r3,r4,r] = Recognition(sRowUs,sRowUs0,sRowVs,sRowVs0,sColUs,sColUs0,sColVs,sColVs0);
     r1,r2,r3,r4,r

end

