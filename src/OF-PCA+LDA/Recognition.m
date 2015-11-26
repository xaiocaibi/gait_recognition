function [ r1,r2,r3,r4,r] = Recognition(sRowUs,sRowUs0,sRowVs,sRowVs0,sColUs,sColUs0,sColVs,sColVs0)
%匹配过程
m=size(sRowUs,2);
for i=1:m
    for j=1:m
        distRU(i,j)=Euclidean(sRowUs(:,j),sRowUs0(:,i));
        distRV(i,j)=Euclidean(sRowVs(:,j),sRowVs0(:,i));
        distCU(i,j)=Euclidean(sColUs(:,j),sColUs0(:,i));
        distCV(i,j)=Euclidean(sColVs(:,j),sColVs0(:,i));
    end
end

%识别率计算过程
r1=0;r2=0;r3=0;r4=0;r=0;%w计数匹配成功数
for i=1:m
    n1=0;n2=0;n3=0;n4=0;
    for j=1:m
        if distRU(i,i)>distRU(j,i)
        else
            n1=n1+1;
        end
         if distRV(i,i)>distRV(j,i)
        else
            n2=n2+1;
         end
         if distCU(i,i)>distCU(j,i)
        else
            n3=n3+1;
         end
         if distCV(i,i)>distCV(j,i)
        else
            n4=n4+1;
        end
    end
    if n1==m
        r1=r1+1;
    end
    if n2==m
        r2=r2+1;
    end
    if n3==m
        r3=r3+1;
    end
    if n4==m
        r4=r4+1;
    end
end
r1=r1/m;r2=r2/m;r3=r3/m;r4=r4/m;
dist=r1*distRU+r2*distRV+r3*distCU+r4*distCV;
r=0;%w计数匹配成功数
for i=1:m
    n=0;
    for j=1:m
        if dist(i,i)>dist(j,i)
            break
        else
            n=n+1;
        end
    end
    if n==m
        r=r+1;
    end
end
r=r/m;
end

