function [] = TestLogisticRegression()
    mapFromIndexToFaces = containers.Map({1,2,3,4,5,6,7,8,9,10},...
        {'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'});
    
    expressions = {'HA','SA','SU','AN','DI','FE','NE'};
    subjectsToImages = LoadData();
    lambdas = [5e-1,2e-1,1e-1,5e-2,2e-2,1e-2,5e-3,2e-3];
    %lambdas = linspace(0.15,0.5,10);
    treeGuidedForAllExpressions = zeros(size(expressions,2),size(lambdas,2));
    lassoGuidedForAllExpression = zeros(size(expressions,2),size(lambdas,2));
    for k=1:size(expressions,2)
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
                
                XTrain = [];
                YTrain = [];
                for trainingSubject=trainingSubjects
                    key = strcat(trainingSubject{1,1},'-',expressions(k));
                    count = size( subjectsToImages(key{1,1}) , 1 );
                    XTrain = [XTrain;subjectsToImages(key{1,1})];
                    YTrain = [YTrain;ones(count,1)];
                    
                    %make other expressions as negative examples
                    remainingExpressions = expressions(~ismember(expressions,expressions(k)));
                    for remainingExpression=remainingExpressions
                        key = strcat(trainingSubject{1,1},'-',remainingExpression{1,1});
                        count = size( subjectsToImages(key) , 1 );
                        XTrain = [XTrain;subjectsToImages(key)];
                        YTrain = [YTrain;-1*ones(count,1)];
                    end
                end
                
                XTest = [];
                YTest = [];
                for testingSubject=testingSubjects
                    key = strcat(testingSubject{1,1},'-',expressions(k));
                    count = size( subjectsToImages(key{1,1}) , 1 );
                    XTest = [XTest;subjectsToImages(key{1,1})];
                    YTest = [YTest;ones(count,1)];
                    
                    %make other expressions as negative examples
                    remainingExpressions = expressions(~ismember(expressions,expressions(k)));
                    for remainingExpression=remainingExpressions
                        key = strcat(testingSubject{1,1},'-',remainingExpression{1,1});
                        count = size( subjectsToImages(key) , 1 );
                        XTest = [XTest;subjectsToImages(key)];
                        YTest = [YTest;-1*ones(count,1)];
                    end
                end
                %[XTrain,YTrain,XTest,YTest] = GetTrainingAndTestingData(trainingSubjects,testingSubjects,expressions{k});
                ind = GenerateIndices();

                %train using tree-guided regularization
                [beta,c] = TreeGuidedLogisticRegression(XTrain,YTrain,ind,lambdas(i));
                YPredict = XTest*beta + c;
                YPredict(YPredict(:) >= 0) = +1;
                YPredict(YPredict(:) < 0) = -1;

                %negative class error
                negativeClassError = sum(YTest == -1 & YPredict == +1)/sum(YTest == -1);

                %positive class error
                positiveClassError = sum(YTest == 1 & YPredict == -1)/sum(YTest == 1);

                berForTree = berForTree + (negativeClassError + positiveClassError)/2;

                %train using lasso penalized logistic regression
                %we have to class labels to 0, because lassoglm requires it
                %in this format
                YTrain(YTrain(:) == -1) = 0;
                tic;
                [betaForLasso,fitInfo] = lassoglm(XTrain,YTrain,'binomial','Lambda',lambdas(i));
                toc;
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
        treeGuidedForAllExpressions(k,:) = treeGuided;
        lassoGuidedForAllExpression(k,:) = lassoGuided;
    end
    
    figure('Name','Comparision of Grouped Tree Structure vs Lasso for Classification');
    subplot(3,2,1);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(1,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(1,:),'g');
    legend('Tree','Lasso');
    title('Happy');
    hold off;

    subplot(3,2,2);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(2,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(2,:),'g');
    legend('Tree','Lasso');
    title('Sad');
    hold off;

    subplot(3,2,3);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(3,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(3,:),'g');
    legend('Tree','Lasso');
    title('Surprise');
    hold off;

    subplot(3,2,4);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(4,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(4,:),'g');
    legend('Tree','Lasso');
    title('Anger');
    hold off;
    
    subplot(3,2,5);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(5,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(5,:),'g');
    legend('Tree','Lasso');
    title('Disgust');
    hold off;

    subplot(3,2,6);
    hold on;
    plot(lambdas,treeGuidedForAllExpressions(6,:),'r');
    plot(lambdas,lassoGuidedForAllExpression(6,:),'g');
    legend('Tree','Lasso');
    title('Fear');
    hold off;
end
    