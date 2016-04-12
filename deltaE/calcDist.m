load images;

org = im2double(imread('happy_dog.jpg'));
%imshow(org)

patchSize = size(IMAGES{1,1},1);
org = imresize(org, 0.1, 'bicubic');
res = zeros(patchSize*size(org,1),patchSize*size(org,2),3);
% Go through image pixel by pixel and "replace" 
% the pixel with a patch

for col = 1:size(org,2) %go through columns
    for row = 1:size(org,1) %go through rows
        pixel = org(row,col,:);
        lab = rgb2lab([pixel(1,1,1) pixel(1,1,2) pixel(1,1,3)]);
        
        tmp = inf;
        for i = 1:size(IMAGES,2)
            dE(i) = sqrt(sum((lab - IMAGES{2,i}).^ 2));
            if (dE(i) < tmp)
                tmp = dE(i);
                id = i;
            end
        end
        res(1+(row-1)*patchSize:(row-1)*patchSize+patchSize,...
            1+(col-1)*patchSize:(col-1)*patchSize+patchSize,:) = IMAGES{1,id};
    end
end
imshow(res);

kitten_dE = res;
save('kitten_dE', 'kitten_dE');

