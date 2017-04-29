function [subjectsToImages] = LoadData()
    subjects = {'KA','KL','KM','KR','MK','NA','NM','TM','UY','YM'};
    expressions = {'HA','SA','SU','AN','DI','FE','NE'};
    
    subjectsToImages = containers.Map;
    for subject=subjects
        directoryPath = strcat('jaffe/',subject{1,1},'/');
        listing = dir(directoryPath);
        for i=1:size(listing,1)
            if( ~isempty( strfind(listing(i).name,'.tiff') ) )
                fileName = strcat(directoryPath,listing(i).name);
                I = imread(fileName);
                I = imresize(I,[64,64]);
                x = double(VectorizeImage(I));
                if( ~isempty( strfind(listing(i).name,'HA')) )
                    key = strcat(subject,'-HA');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty( strfind(listing(i).name,'SA')) )
                    key = strcat(subject,'-SA');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty( strfind(listing(i).name,'SU')) )
                    key = strcat(subject,'-SU');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty(strfind(listing(i).name, 'AN')) )
                    key = strcat(subject,'-AN');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty(strfind(listing(i).name,'DI')) )
                    key = strcat(subject,'-DI');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty(strfind(listing(i).name,'FE')) )
                    key = strcat(subject,'-FE');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                elseif( ~isempty(strfind(listing(i).name,'NE')) )
                    key = strcat(subject,'-NE');
                    if(isKey(subjectsToImages,key))
                        images = values(subjectsToImages,{ key{1,1} });
                        images{1,1}(end+1,:) =  x;
                        subjectsToImages(key{1,1}) = images{1,1};
                    else
                         subjectsToImages( key{1,1} ) = x;
                    end
                end
            end
        end
    end
    disp('subjects loaded');
    totalCount = 0;
    for subject=subjects
        for expression=expressions
            key = strcat(subject,'-',expression);
            totalCount = totalCount + size(subjectsToImages(key{1,1}),1);
        end
    end
    disp(totalCount);
end