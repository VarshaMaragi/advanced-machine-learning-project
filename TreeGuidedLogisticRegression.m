function [beta,c] = TreeGuidedLogisticRegression(X,Y,ind,lambda)
    opts = [];
    opts.init = 2;
    opts.tFlag = 5;
    opts.maxIter = 100;
    opts.rFlag = 0;
    opts.nFlag = 0;
    opts.ind = ind;
    
    tic;
    [beta,c] = tree_LogisticR(X,Y,lambda,opts);
    toc;
end