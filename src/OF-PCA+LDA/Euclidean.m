function [ dist] = Euclidean( R,T )
Euc=(R-T).^2;
dist=0;
for i=1:length(Euc)
    dist=dist+Euc(i);
end
end

