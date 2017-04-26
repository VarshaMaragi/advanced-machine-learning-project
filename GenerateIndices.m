function [ind] = GenerateIndices()
    b = 16;
    treeDepth = 3;
    nodes = (b^(treeDepth+1) - 1) / (b-1);
    ind = ones(3,nodes);
    
    depth = treeDepth;
    while(depth >= 0)
        if(depth == treeDepth)
            [s1,e1] = GetStartingAndEndingIndices(b,depth);
            for i=s1:e1
                ind(1,i) = i;
                ind(2,i) = i;
            end
        else
            [s1,e1] = GetStartingAndEndingIndices(b,depth);
            [s2,e2] = GetStartingAndEndingIndices(b,depth+1);
            j = s2;
            for i=s1:e1
                ind(1,i) = ind(1,j);
                ind(2,i) = ind(2,j+b-1);
                j = j + b;
            end
        end
        depth = depth - 1;
    end
end