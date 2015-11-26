function [CenterAEI] = Center(AEI)
%求质心
[row,column]=find(AEI);
Coordinates=[row,column];
centroid=mean( Coordinates);
X1=centroid(2);
b=round(160-X1);
a=0;
se=translate(strel(1),[a,b]);
CenterAEI=imdilate(AEI,se);%平移
end

