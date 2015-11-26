function [ ] = OFHI(BW)
%得到光流矢量分量
for i=1:length(BW)-1
    [us,vs]=OpticalFlow(BW{i},BW{i+1});
    mus{i}=us;
    mvs{i}=vs;
end
%每两帧图像之间光流矢量的长度矩阵muv和弧度矩阵mmm
[row,col]=size(mus{1});
for k=1:1:length(mus)
    muv{k}=sqrt(mus{k}.^2 + mvs{k}.^2);
    for i=1:1:row
        for j=1:1:col
            if mus{k}(i,j) == 0 && mvs{k}(i,j) == 0
                mmm{k}(i,j)=0;
            elseif mus{k}(i,j) >= 0
                mmm{k}(i,j)=asin(mvs{k}(i,j)/muv{k}(i,j));
            else  
                mmm{k}(i,j)=(-asin(mvs{k}(i,j)/muv{k}(i,j)) + pi );
            end
        end
    end
end

%把长度矩阵muv和弧度矩阵mmm分别映射为向量lmuv和lmmm
for k=1:length(muv)
    m=1;
    for i=1:row
        for j=1:col
            if muv{k}(i,j)==0;
            else
                lmuv{k}(m)=muv{k}(i,j);
                lmmm{k}(m)=mmm{k}(i,j);
                m=m+1;
            end
        end
    end
    %对lmmm元素值去重处理
    for i=1:length(lmmm{k})
        for j=i+1:length(lmmm{k})
            if lmmm{k}(i)==lmmm{k}(j)
                lmuv{k}(i)=lmuv{k}(i)+lmuv{k}(j);%求相同角度值长度的和
                lmuv{k}(j)=0;
            end
        end

    end
    n=1;
    for i=1:length(lmmm{k})
        if lmuv{k}(i)==0
            continue;
        else
            lmmm1{k}(n)=lmmm{k}(i);
            lmuv1{k}(n)=lmuv{k}(i);
            n=n+1;
        end
    end
end
figure
for k=1:length(muv)
    hold on
    bar(lmmm1{k},lmuv1{k},'b');
    title('GOFHI');
end
end

