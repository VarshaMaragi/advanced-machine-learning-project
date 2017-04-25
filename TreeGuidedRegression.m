function [x, funVal] = TreeGuidedRegression(X,Y,ind)
    opts = [];
    opts.init = 2;
    opts.tFlag = 5;
    opts.maxIter = 100;
    opts.rFlag = 1;
    opts.nFlag = 0;
    opts.ind = ind;
    
    lambda = 0.1;
    tic;
    [x,funVal] = tree_LeastR(X,Y,lambda,opts);
    toc;
end