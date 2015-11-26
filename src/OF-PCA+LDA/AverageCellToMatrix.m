function [ AverageVectorMatrix ] = AverageCellToMatrix(eigcell)  
    %求类内特征向量的平均值组成的矩阵
    %eigcell必须为维度校正后的元胞数组
    p=size(eigcell{1},1);
    AverageVectorMatrix(length(eigcell),size(eigcell{1},2))=0;
    for k=1:length(eigcell)
        for j=1:size(eigcell{1},2)
            for n=1:p
                AverageVectorMatrix(k,j)=AverageVectorMatrix(k,j)+eigcell{k}(n,j);
            end
       end
    end
    AverageVectorMatrix=AverageVectorMatrix/size(eigcell{1},1);
end

