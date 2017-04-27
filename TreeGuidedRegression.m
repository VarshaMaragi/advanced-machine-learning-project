function [Beta] = TreeGuidedRegression(X,Y,ind,lambda)
    opts = [];
    opts.init = 2;
    opts.tFlag = 5;
    opts.maxIter = 100;
    opts.rFlag = 0;
    opts.nFlag = 0;
    opts.ind = ind;
    
    %[beta,~] = tree_LeastR(X,Y,lambda,opts);
    %regression model for happiness
    tic;
    [beta1,funVal1] = tree_LeastR(X,Y(:,1),lambda,opts);
    toc;
    
    %regression model for sadness
    tic;
    [beta2,funVal2] = tree_LeastR(X,Y(:,2),lambda,opts);
    toc;
    
    %regression model for surprise
    tic;
    [beta3,funVal3] = tree_LeastR(X,Y(:,3),lambda,opts);
    toc;
    
    %regression model for anger
    tic;
    [beta4,funVal4] = tree_LeastR(X,Y(:,4),lambda,opts);
    toc;
    
    %regression model for disgust
    tic;
    [beta5,funVal5] = tree_LeastR(X,Y(:,5),lambda,opts);
    toc;
    
    %regression model for fear
    tic;
    [beta6,funVal6] = tree_LeastR(X,Y(:,6),lambda,opts);
    toc;
    Beta = [beta1,beta2,beta3,beta4,beta5,beta6];
end