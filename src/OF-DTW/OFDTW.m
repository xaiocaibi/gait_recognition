function [ ] = OFDTW( )
%DTW算法匹配距离显示
m=2;%模板样本个数
for i=1:m;
%求出同一个人在不同状态下行或者列的某一方向矢量和
  for j=1:5
    if i<10
         fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\00',int2str(i),'\nm-0',int2str(j),'\090\');
        BW1=OFReadpic(fileFolder{i});
    elseif i<100
         fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\0',int2str(i),'\nm-0',int2str(j),'\090\');
         BW1=OFReadpic(fileFolder{i});
    else 
         fileFolder{i} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\',int2str(i),'\nm-0',int2str(j),'\090\');
        BW1=OFReadpic(fileFolder{i});
    end
    RowUs11{j}=OFRowUsSymmetry(BW1);%RoWUs11表示个体i在状态j下每行向左的光流矢量和的向量
  end
  %RowUs11的长度归整
  for k=1:length(RowUs11)
      x(k)=length(RowUs11{k});
  end
  maxm=max(x);
  for n=1:length(RowUs11)
    if (maxm-length(RowUs11{n}))>0
        p=maxm-length(RowUs11{n});
        for q=length(RowUs11{n})+1:p+length(RowUs11{n})
            RowUs11{n}(q)=0;
        end
    end
  end
  %RowUs1为同一个人不同状态下的矢量和叠加
 for k=1:length(RowUs11{1})
     RowUs1{i}(k)=0;
     for j=1:length(RowUs11)
         RowUs1{i}(k)=RowUs1{i}(k)+RowUs11{j}(k);
     end
 end
 %求RowUs1的平均值
 for k=1:length(RowUs11{1})
     RowUs1{i}(k)=RowUs1{i}(k)/length(RowUs11);
 end
end
%测试样本的行或者列的同一方向矢量和
for j=1:m
    if j<10
        fileFolder{j} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\00',int2str(j),'\nm-06\090\');
        BW2=OFReadpic(fileFolder{j});
    elseif j<100
        fileFolder{j} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\0',int2str(j),'\nm-06\090\');
        BW2=OFReadpic(fileFolder{j});
    else
        fileFolder{j} = strcat('E:\步态识别研究\步态识别\数据库\GaitDatasetB-silh\DatasetB\silhouettes\',int2str(j),'\nm-06\090\');
        BW2=OFReadpic(fileFolder{j});
    end
    RowUs2{j}=OFRowUsSymmetry(BW2);
end
%DTW匹配距离计算
for i=1:m
    for j=1:m
        dist(i,j)=DTW(RowUs1{i},RowUs2{j});
    end
end
dist
end

