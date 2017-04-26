function [ind] = GenerateIndices()
    %generate leaf level nodes
    %level-3
    ind = [-1,-1,1]';
    
    %one level higher
    %level-2
    i = 0;
    for k=1:256
        ind = [ind,[16*i + 1,16*(i+1),sqrt(16)]'];
        i = i + 1;
    end
    
    %level-1
    i = 0;
    for k=1:16
        ind = [ind,[256*i + 1,256*(i+1),sqrt(256)]'];
        i = i + 1;
    end
end