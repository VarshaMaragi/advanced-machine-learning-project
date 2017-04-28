function [] = TestRegression()
    mapFromIndexToFaces = containers.Map({1,2,3,4,5,6,7,8,9,10},...
        {'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'});
    
    lambdas = [5e-1,2e-1,1e-1,5e-2,2e-2,1e-2,5e-3,2e-3];
    %lambdas = [5e-1,2e-1];
    %six expressions
    treeGuidedRMSE = zeros(6,size(lambdas,2));
    lassoRMSE = zeros(6,size(lambdas,2));
    for i=1:size(lambdas,2)
        %six expressions
        rmseForTreeGuided = zeros(1,6);
        rmseForLasso = zeros(1,6);
        for j=1:10
            %randomly generate training subjects
            trainingIndexes = datasample(1:10,8,'Replace',false);
            testingIndexes = setdiff(1:10,trainingIndexes);

            %preprocess the images
            [X,Y,ind] = PreProcess();

            %get the training and testing subjects like 'KA','KL' etc
            trainingSubjects = values(mapFromIndexToFaces,num2cell(trainingIndexes));
            testingSubjects = values(mapFromIndexToFaces,num2cell(testingIndexes));

            %now get the actual training images
            XTrain = values(X,trainingSubjects);
            YTrain = values(Y,trainingSubjects);

            A = [];
            B = [];

            for cell=XTrain
                A = [A;cell{1,1}];
            end

            for cell=YTrain
                B = [B;cell{1,1}];
            end

            %tree guided sparsity
            beta = TreeGuidedRegression(A,B,ind,lambdas(i));

            %lasso
            betaLasso = [];
            for k=1:size(B,2)
                betaLasso = [betaLasso,lasso(A,B(:,k),'Lambda',lambdas(i))];
            end
            
            %get the testing data
            XTest = values(X,testingSubjects);
            YTest = values(Y,testingSubjects);

            ATest = [];
            bTest = [];
            for cell=XTest
               ATest = [ATest;cell{1,1}];
            end

            for cell=YTest
                bTest = [bTest;cell{1,1}];
            end

            bPredict = ATest*beta;
            for k=1:size(bPredict,2)
               rmse = sqrt( norm(bPredict(:,k) - bTest(:,k),2)^2 / size(bPredict(:,k),1) );
               rmseForTreeGuided(k) = rmseForTreeGuided(k) + rmse;
            end
            
            bPredictLasso = ATest*betaLasso;
            for k=1:size(bPredictLasso,2)
                rmse = sqrt( norm(bPredictLasso(:,k) - bTest(:,k),2)^2 / size(bPredictLasso(:,k),1) );
                rmseForLasso(k) = rmseForLasso(k) + rmse;
            end
        end
        treeGuidedRMSE(:,i) = rmseForTreeGuided'/10;
        lassoRMSE(:,i) = rmseForLasso'/10;
        %treeGuidedRMSE(end+1) = rmseForTreeGuided/10;
        %lassoRMSE(end+1) = rmseForLasso/10;
    end
%     figure('Name','Happy');
%     title('RMSE comparison for Grouped Tree Structure vs Lasso');
%     hold on;
%     plot(lambdas,treeGuidedRMSE,'r');
%     plot(lambdas,lassoRMSE,'g');
%     legend('Grouped Tree Structure','Lasso');
%     hold off;
    figure('Name','Comparision of Grouped Tree Structure vs Lasso for Regression');
    subplot(3,2,1);
    hold on;
    plot(lambdas,treeGuidedRMSE(1,:),'r');
    plot(lambdas,lassoRMSE(1,:),'g');
    legend('Tree','Lasso');
    title('Happy');
    hold off;

    subplot(3,2,2);
    hold on;
    plot(lambdas,treeGuidedRMSE(2,:),'r');
    plot(lambdas,lassoRMSE(2,:),'g');
    legend('Tree','Lasso');
    title('Sad');
    hold off;

    subplot(3,2,3);
    hold on;
    plot(lambdas,treeGuidedRMSE(3,:),'r');
    plot(lambdas,lassoRMSE(3,:),'g');
    legend('Tree','Lasso');
    title('Surprise');
    hold off;

    subplot(3,2,4);
    hold on;
    plot(lambdas,treeGuidedRMSE(4,:),'r');
    plot(lambdas,lassoRMSE(4,:),'g');
    legend('Tree','Lasso');
    title('Anger');
    hold off;
    
    subplot(3,2,5);
    hold on;
    plot(lambdas,treeGuidedRMSE(5,:),'r');
    plot(lambdas,lassoRMSE(5,:),'g');
    legend('Tree','Lasso');
    title('Disgust');
    hold off;

    subplot(3,2,6);
    hold on;
    plot(lambdas,treeGuidedRMSE(6,:),'r');
    plot(lambdas,lassoRMSE(6,:),'g');
    legend('Tree','Lasso');
    title('Fear');
    hold off;
end
    