function [ProjectRU,sRowUs,ProjectRV,sRowVs,ProjectCU,sColUs,ProjectCV,sColVs]=PcaPlusLda(RowUsMatrix,RowVsMatrix,ColUsMatrix,ColVsMatrix)
%求解PCA+LDA投影空间
%维度归一化后形成特征矩阵
for p=1:4
    if p==1
        EigCell=RowUsMatrix;
    elseif p==2
        EigCell=RowVsMatrix;
    elseif p==3
        EigCell=ColUsMatrix;
    else
        EigCell=ColVsMatrix;
    end    
    %维度归整
    [ EigCell ] = CellDimensionAlign( EigCell );
    
    %求类内特征向量的平均值构成的矩阵
    [ EigAveMatrix ] = AverageCellToMatrix(EigCell); 
   
    %PCA过程
    [PcaProject] = PCA( EigAveMatrix );
        
    %LDA过程
    for i=1:length(EigCell)
        EigPcaProject{i}=PcaProject'*EigCell{i}';
    end;
    [ LdaProject ]=LDA(EigPcaProject);
   
    %PCA+LDA合并
    PLProject=LdaProject'*PcaProject';
    
    if p==1
       ProjectRU=PLProject;%aRowUs表示个体i在不同情况下行的左右运动矢量和向量的平均值
       sRowUs=PLProject*EigAveMatrix';
    elseif p==2
       ProjectRV=PLProject;
       sRowVs=PLProject*EigAveMatrix';
    elseif p==3
       ProjectCU=PLProject;
       sColUs=PLProject*EigAveMatrix';
    elseif p==4
       ProjectCV=PLProject;
       sColVs=PLProject*EigAveMatrix';
    end
end
end
