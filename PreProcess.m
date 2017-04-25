function [ X ] = PreProcess()
    listing = dir('jaffe/');
    X = [];
    for i=1:size(listing,1)
        if( ~isempty( strfind(listing(i).name,'.tiff') ) )
            fileName = strcat('jaffe/',listing(i).name);
            I = imread(fileName);
            I = imresize(I,[64,64]);
            x = reshape(I,[1,64*64]);
            X = [X;x];
        end
    end
end

