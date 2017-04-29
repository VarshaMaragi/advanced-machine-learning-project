function [ X, Y ] = PreProcess()
    listing = dir('jaffe/');
    Y = containers.Map;
    KA = [];
    KL = [];
    KM = [];
    KR = [];
    MK = [];
    NA = [];
    NM = [];
    TM = [];
    UY = [];
    YM = [];
    for i=1:size(listing,1)
        if( ~isempty( strfind(listing(i).name,'.tiff') ) )
            fileName = strcat('jaffe/',listing(i).name);
            if(strfind(fileName,'KA.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KA = [KA;double(x)];
                Y('KA') = csvread('jaffe/Y-KA-reordered.csv',1,0);
            elseif(strfind(fileName,'KL.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KL = [KL;double(x)];
                Y('KL') = csvread('jaffe/Y-KL-reordered.csv',1,0);
            elseif(strfind(fileName,'KM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KM = [KM;double(x)];
                Y('KM') = csvread('jaffe/Y-KM-reordered.csv',1,0);
            elseif(strfind(fileName,'KR.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KR = [KR;double(x)];
                Y('KR') = csvread('jaffe/Y-KR-reordered.csv',1,0);
            elseif(strfind(fileName,'MK.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                MK = [MK;double(x)];
                Y('MK') = csvread('jaffe/Y-MK-reordered.csv',1,0);
            elseif(strfind(fileName,'NA.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                NA = [NA;double(x)];
                Y('NA') = csvread('jaffe/Y-NA-reordered.csv',1,0);
            elseif(strfind(fileName,'NM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                NM = [NM;double(x)];
                Y('NM') = csvread('jaffe/Y-NM-reordered.csv',1,0);
            elseif(strfind(fileName,'TM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                TM = [TM;double(x)];
                Y('TM') = csvread('jaffe/Y-TM-reordered.csv',1,0);
            elseif(strfind(fileName,'UY.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                UY = [UY;double(x)];
                Y('UY') = csvread('jaffe/Y-UY-reordered.csv',1,0);
            elseif(strfind(fileName,'YM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                YM = [YM;double(x)];
                Y('YM') = csvread('jaffe/Y-YM-reordered.csv',1,0);
            end
        end
    end
    
    X = containers.Map({'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'},...
        {KA,KL,KM,KR,MK,NA,NM,TM,UY,YM});
    
%     subjects = {'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'};
%     totalCount = 0;
%     for subject=subjects
%         disp(size(Y(subject{1,1}),1));
%         totalCount = totalCount + size(Y(subject{1,1}),1);
%     end
%     disp('----------------');
%     disp(totalCount);
end

