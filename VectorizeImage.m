function [V]=VectorizeImage(X)
    V = [];
    if(size(X,1)==2 && size(X,2)==2)
        V = reshape(X',[2,2]);
    elseif(size(X,1)==1 && size(X,2)==1)
            V = X;
    else
        [m,n] = size(X);
        blocks = mat2cell(X,[m/4,m/4,m/4,m/4],[n/4,n/4,n/4,n/4]);
        for i = 1:4
            for j = 1:4
                V = [V,VectorizeImage(blocks{i,j})];
            end
        end
    end
end