function [ arr ] = reshapImg( img, patchSize )
% Reshape an image to an array.
    arr = zeros(patchSize, patchSize*(size(img,2)/patchSize)*(size(img,1)/patchSize),3);
    j = 1;
    for i = 1 : patchSize : size(img,1) - patchSize 
        arr(1:patchSize, j:j + size(img,2)-1, :) = img(i:i+patchSize-1, 1:size(img,2),:);

        j = j + size(img,2);
    end
end

