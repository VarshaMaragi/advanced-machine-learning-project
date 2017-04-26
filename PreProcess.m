function [ X, Y, ind ] = PreProcess()
    listing = dir('jaffe/');
    X = [];
    for i=1:size(listing,1)
        if( ~isempty( strfind(listing(i).name,'.tiff') ) )
            fileName = strcat('jaffe/',listing(i).name);
            I = imread(fileName);
            %I = imresize(I,[64,64]);
            I = imresize(I,[64,64]); 
            x = VectorizeImage(I);                   
            X = [X;double(x)];
            %X = [X;x];
        end
    end
    Y = csvread('jaffe/Y2.csv',1,0);
    %Y = Y(:,1);
    ind = GenerateIndices();
%     ind = [[-1,-1,1]',...% leave nodes (each node contains one feature)
%             [1,16,sqrt(16)]',[17,32,sqrt(16)]',[33,48,sqrt(16)]',[49,64,sqrt(16)]',[65,80,sqrt(16)]',... %one layer higher
%             [81,96,sqrt(16)]',[97,112,sqrt(16)]',[113,128,sqrt(16)]',[129,144,sqrt(16)]',[145,160,sqrt(16)]',...
%             [161,176,sqrt(16)]',[177,192,sqrt(16)]',[193,208,sqrt(16)]',[209,224,sqrt(16)]',[225,240,sqrt(16)]',...
%             [241,256,sqrt(16)]'];
end

