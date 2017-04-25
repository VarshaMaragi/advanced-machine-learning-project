function [ X, Y, ind ] = PreProcess()
    listing = dir('jaffe/');
    X = [];
    for i=1:size(listing,1)
        if( ~isempty( strfind(listing(i).name,'.tiff') ) )
            fileName = strcat('jaffe/',listing(i).name);
            I = imread(fileName);
            %I = imresize(I,[64,64]);
            %x = reshape(I,[1,4*4]);
            I = imresize(I,[4,4]);
            blocks = mat2cell(I,[2,2],[2,2]);
            b1 = reshape(blocks{1,1}',[1,4]);
            b2 = reshape(blocks{1,2}',[1,4]);
            b3 = reshape(blocks{2,1}',[1,4]);
            b4 = reshape(blocks{2,2}',[1,4]);
            x = [b1,b2,b3,b4];
            X = [X;double(x)];
            %X = [X;x];
        end
    end
    Y = csvread('jaffe/Y2.csv');
    Y = Y(:,1);
    ind = GenerateIndices();
end

