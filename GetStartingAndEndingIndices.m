function [startingIndex,endIndex] = GetStartingAndEndingIndices(b,d)
    %note that indexing starts from 1
    startingIndex = (b^d - 1)/(b - 1) + 1;
    endIndex = startingIndex + b^d - 1;
end