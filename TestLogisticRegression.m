function [] = TestLogisticRegression()
    mapFromIndexToFaces = containers.Map({1,2,3,4,5,6,7,8,9,10},...
        {'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'});
    
    expressions = ['HA','SA','SU','AN','DI','FE'];
    %lambdas = [5e-1,2e-1,1e-1,5e-2,2e-2,1e-2,5e-3,2e-3];
    lambdas = linspace(0.15,0.5,10);
    treeGuided = zeros(1,size(lambdas,2));
    lassoGuided = zeros(1,size(lambdas,2));
    for i=1:size(lambdas,2)
        berForTree = 0;
        berForLasso = 0;
        for j=1:10
            trainingIndexes = datasample(1:10,8,'Replace',false);
            testingIndexes = setdiff(1:10,trainingIndexes);

            %get the training and testing subjects like 'KA','KL' etc
            trainingSubjects = values(mapFromIndexToFaces,num2cell(trainingIndexes));
            testingSubjects = values(mapFromIndexToFaces,num2cell(testingIndexes));

            [XTrain,YTrain,XTest,YTest] = GetTrainingAndTestingData(trainingSubjects,testingSubjects,'HA');
            ind = GenerateIndices();

            %train using tree-guided regularization
            [beta,c] = TreeGuidedLogisticRegression(XTrain,YTrain,ind,lambdas(i));
            YPredict = XTest*beta + c;
            YPredict(YPredict(:) >= 0) = +1;
            YPredict(YPredict(:) < 0) = -1;

            %true negative class error
            negativeClassError = sum(YTest == -1 & YPredict == +1)/sum(YTest == -1);

            %true positive class error
            positiveClassError = sum(YTest == 1 & YPredict == -1)/sum(YTest == 1);

            berForTree = berForTree + (negativeClassError + positiveClassError)/2;

            %train using lasso penalized logistic regression
            YTrain(YTrain(:) == -1) = 0;
            [betaForLasso,fitInfo] = lassoglm(XTrain,YTrain,'binomial','Lambda',lambdas(i));
            YPredict = XTest*betaForLasso + fitInfo.Intercept;
            YPredict(YPredict(:) >= 0) = +1;
            YPredict(YPredict(:) < 0) = -1;

            %true negative class error
            negativeClassError = sum(YTest == -1 & YPredict == +1)/sum(YTest == -1);

            %true positive class error
            positiveClassError = sum(YTest == 1 & YPredict == -1)/sum(YTest == 1);

            berForLasso = berForLasso + (negativeClassError + positiveClassError)/2;
        end
        treeGuided(i) = berForTree/10;
        lassoGuided(i) = berForLasso/10;
    end
    figure('Name','Classification with vs Tree-Structured penalty vs Lasso Penalty');
    hold on;
    plot(lambdas,treeGuided,'r');
    plot(lambdas,lassoGuided,'g');
    title('Happy');
    legend('Tree Guided','Lasso');
    hold off;
end
    