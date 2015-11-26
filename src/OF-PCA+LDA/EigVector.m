function [RowUs1,RowVs1,ColUs1,ColVs1] = EigVector(RowUs,RowVs,ColUs,ColVs)
%不同个体四个特征值在不同情况下的向量规整矩阵化过程
    for p=1:4
        if p==1
           eigmatrix=RowUs;
        elseif p==2
           eigmatrix=RowVs;
        elseif p==3
           eigmatrix=ColUs;
        else
           eigmatrix=ColVs;
        end    

        %维度归整
        [eigmatrix] = CellDimensionAlign( eigmatrix );
        
        %矩阵化
        eigvector=0;
        for j=1:length(eigmatrix)
            for k=1:length(eigmatrix{1})
                eigvector(j,k)=eigmatrix{j}(k);
            end
        end

        if p==1
           RowUs1=eigvector;%aRowUs表示个体i在不同情况下行的左右运动矢量和向量的平均值
        elseif p==2
           RowVs1=eigvector;
        elseif p==3
           ColUs1=eigvector;
        elseif p==4
           ColVs1=eigvector;
        end     
    end
end

