function [CenterAEI] = Center(AEI)
%把图像移到同一个点

%求质心
[row,column]=find(AEI);
Coordinates=[row,column];
centroid=mean( Coordinates);
X1=centroid(2);

%平移量
b=round(160-X1);
a=0;

%平移过程
se=translate(strel(1),[a,b]);
CenterAEI=imdilate(AEI,se);

end

