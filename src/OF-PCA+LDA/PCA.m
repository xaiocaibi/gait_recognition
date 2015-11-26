function [Project] = PCA( EigAveMatrix )
 %PCA过程，coeff表示投影矩阵，score表示投影后新样本矩阵，latent表示特征值向量，Project选取主成分后的新投影矩阵
    [coeff,score,latent]=princomp(EigAveMatrix);
    SumEnergy=0;
    for j=1:length(latent)
            SumEnergy=SumEnergy+latent(j);
            if (SumEnergy/sum(latent))>=0.99
                break;
            end
    end
    
    for k=1:j
        Project(:,k)=coeff(:,k);
    end

end

