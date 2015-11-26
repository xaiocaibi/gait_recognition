function [dist] =DTW(R,T)
%两个列质量匹配，结果为S
%R,T都为列质量向量R=(r1,r2,...,rm) ,T=(t1,t2,...,tn)
[s,m] =size(R);
[t,n]=size(T);
S=zeros(m,n);
%每一行加上ri
for i=1:m
    S(i,:) =S(i,:)+ R(1,i);
end
%每一列减tj
for j=1:n
    S(:,j)=S(:,j)-T(1,j); 
end
S = abs(S);
D=zeros(m,n);
for i = 1:m
    for j = 1:n
        if i==1&&j==1
           D(1,1) = S(1,1);
           D1=0;
           D2=0;
           D3=0;
        end
        if i==1&&j>1
           D1 = D(i,j-1); 
           D2=realmax;
           D3=realmax;
        end
        if i>1&&j==1
           D1 = D(i-1,j); 
           D2=realmax;
           D3=realmax;
        end
        if i>1&&j>1
           D1 = D(i-1,j-1); 
           D2=D(i-1,j);
           D3=D(i,j-1);
        end
   D(i,j) = S(i,j) + min([D1,D2,D3]);
   end
end
   %计算dist，得到测试序列到各个模板序列的最短匹配距离
   dist = D(m,n);
end
  %dist;
  %得到最小的dist，得到模板序列号