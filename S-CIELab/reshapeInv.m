function [ img ] = reshapeInv( arr, width,height )
% Reshape array to image

    img = zeros(height, width, 3);
    j = 1;
    patchSize = size(arr, 1);
    for  i = 1 : patchSize : size(img,1) - patchSize   
        img(i:i+patchSize-1, 1:size(img,2),:) = arr(1:patchSize, j:j + size(img,2)-1, :);
        j = j + size(img,2);
    end
end

