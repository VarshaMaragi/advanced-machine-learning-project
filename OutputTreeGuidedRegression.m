function [beta] = OutputTreeGuidedRegression(X,y,ind_t,lambda)
    %six regression tasks
    k = 6;
    [m,n] = size(X);
    opts = [];
    opts.init = 2;
    opts.tFlag = 5;
    opts.maxIter = 100;
    opts.rFlag = 0;
    opts.nFlag = 0;
    opts.ind_t = ind_t;
    opts.ind = [0,m/k:m/k:m];
    
    %[beta,~] = tree_LeastR(X,Y,lambda,opts);
    %regression model for happiness
    tic;
    [beta,funVal] = tree_mtLeastR(X,y,lambda,opts);
    toc;
end