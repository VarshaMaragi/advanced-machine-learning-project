function [ X, Y, ind ] = PreProcess()
    listing = dir('jaffe/');
    X = [];
    for i=1:size(listing,1)
        if( ~isempty( strfind(listing(i).name,'.tiff') ) )
            fileName = strcat('jaffe/',listing(i).name);
            I = imread(fileName);
            %I = imresize(I,[64,64]);
            %x = reshape(I,[1,4*4]);
            I = imresize(I,[64,64]);
     
            
            x = VectorizeImage(I);                   
            X = [X;double(x)];
            %X = [X;x];
        end
    end
    Y = csvread('jaffe/Y2.csv');
    Y = Y(:,1);
    ind = GenerateIndices();
end

