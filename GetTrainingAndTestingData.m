function [XTrain,YTrain,XTest,YTest] = GetTrainingAndTestingData(trainingSubjects,testingSubjects,expression)
    %training images
    XTrain = [];
    YTrain = [];
    
    listing = dir('jaffe/');
    for cell=trainingSubjects
        directoryPath = strcat('jaffe/',cell{1,1},'/');
        folder = dir(directoryPath);
        for i=1:size(folder,1)
            if( ~isempty( strfind(folder(i).name,'.tiff') ) )
                fileName = strcat(directoryPath,folder(i).name);
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                XTrain = [XTrain;double(VectorizeImage(I))];
                %if the image is of type expression, set the label to +1 else -1
                if( ~isempty( strfind(folder(i).name,expression) ) )
                    YTrain = [YTrain;1];
                else
                   YTrain = [YTrain;-1]; 
                end
            end
        end
    end
    
    %testing images
    XTest = [];
    YTest = [];
    for cell=testingSubjects
        directoryPath = strcat('jaffe/',cell{1,1},'/');
        folder = dir(directoryPath);
        for i=1:size(folder,1)
            if( ~isempty( strfind(folder(i).name,'.tiff') ) )
                fileName = strcat(directoryPath,folder(i).name);
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                XTest = [XTest;double(VectorizeImage(I))];
                %if the image is of type expression, set the label to +1 else -1
                if( ~isempty( strfind(folder(i).name,expression) ) )
                    YTest = [YTest;1];
                else
                   YTest = [YTest;-1];
                end
            end
        end
    end
end