function    [ W ]=LDA( D ) 
%LDA过程
%D包含n个元胞数组，每数组是ixj的矩阵，输出N为LDA后的投影矩阵

%转置
for i=1:length(D)
    X{i}=D{i}';
end

%求类内特征向量的平均值构成的矩阵,m位个体在不同情况下平均值形成的矩阵
[ m ] = AverageCellToMatrix(X); 

%求总体平均值M
M(size(m,2))=0;
for i=1:size(m,2)
    for j=1:size(m,1)
        M(i)=M(i)+m(j,i);
    end
end
M=M/size(m,1);

%总的类内散布矩阵
s(length(size(D{1},2)),length(size(D{1},2)))=0;
Sw=s;
for i=1:length(X)
    for j=1:size(X{i},1)
        s=s+(X{i}(j,:)-m(j,:))'*(X{i}(j,:)-m(j,:));
    end
    Sw=Sw+s;
end

%总的类间散布矩阵
Sb(length(size(D{1},2)),length(size(D{1},2)))=0;
for i=1:length(X)
    Sb=Sb+size(X{i},1)*(m(i,:)-M)'*(m(i,:)-M);
end

%W的每一列为对角矩阵E中特征值对应的特征向量
[W,E]=eig((inv(Sw))*Sb);



end

