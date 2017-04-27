function [ X, Y, ind ] = PreProcess()
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
                Y('KA') = csvread('jaffe/Y-KA.csv');
            elseif(strfind(fileName,'KL.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KL = [KL;double(x)];
                Y('KL') = csvread('jaffe/Y-KL.csv');
            elseif(strfind(fileName,'KM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KM = [KM;double(x)];
                Y('KM') = csvread('jaffe/Y-KM.csv');
            elseif(strfind(fileName,'KR.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                KR = [KR;double(x)];
                Y('KR') = csvread('jaffe/Y-KR.csv');
            elseif(strfind(fileName,'MK.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                MK = [MK;double(x)];
                Y('MK') = csvread('jaffe/Y-MK.csv');
            elseif(strfind(fileName,'NA.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                NA = [NA;double(x)];
                Y('NA') = csvread('jaffe/Y-NA.csv');
            elseif(strfind(fileName,'NM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                NM = [NM;double(x)];
                Y('NM') = csvread('jaffe/Y-NM.csv');
            elseif(strfind(fileName,'TM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                TM = [TM;double(x)];
                Y('TM') = csvread('jaffe/Y-TM.csv');
            elseif(strfind(fileName,'UY.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                UY = [UY;double(x)];
                Y('UY') = csvread('jaffe/Y-UY.csv');
            elseif(strfind(fileName,'YM.'))
                I = imread(fileName);
                I = imresize(I,[64,64]); 
                x = VectorizeImage(I);
                YM = [YM;double(x)];
                Y('YM') = csvread('jaffe/Y-YM.csv');
            end
        end
    end
    
    X = containers.Map({'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'},...
        {KA,KL,KM,KR,MK,NA,NM,TM,UY,YM});
    
    ind = GenerateIndices();
%     ind = [[-1,-1,1]',...% leave nodes (each node contains one feature)
%             [1,16,sqrt(16)]',[17,32,sqrt(16)]',[33,48,sqrt(16)]',[49,64,sqrt(16)]',[65,80,sqrt(16)]',... %one layer higher
%             [81,96,sqrt(16)]',[97,112,sqrt(16)]',[113,128,sqrt(16)]',[129,144,sqrt(16)]',[145,160,sqrt(16)]',...
%             [161,176,sqrt(16)]',[177,192,sqrt(16)]',[193,208,sqrt(16)]',[209,224,sqrt(16)]',[225,240,sqrt(16)]',...
%             [241,256,sqrt(16)]'];
end

