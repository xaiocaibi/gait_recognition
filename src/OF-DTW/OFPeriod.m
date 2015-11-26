function [sum ] = OFPeriod(BW)
%得到光流矢量分量
for i=1:length(BW)-1
    [us,vs]=OpticalFlow(BW{i},BW{i+1});
    mvs{i}=vs;
end
%周期检测
for k=1:length(mvs)
    [row,col]=size(mvs{k});
    sum(k)=0;
    for i=1:row
        for j=1:col
           sum(k)=sum(k)+mvs{k}(i,j);
        end
    end
end
figure
plot(sum,'r-*');
summ(1)=sum(1);
for i=2:length(sum)
    summ=summ+sum(i);
end
end

