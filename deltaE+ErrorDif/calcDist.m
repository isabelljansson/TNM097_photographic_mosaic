load images;

org = im2double(imread('happy_dog.jpg'));
%imshow(org)

patchSize = size(IMAGES{1,1},1);
org = rgb2xyz(imresize(org, 0.1, 'bicubic'));
res = zeros(patchSize*size(org,1),patchSize*size(org,2),3);
% Go through image pixel by pixel and "replace" 
% the pixel with a patch

for col = 1:size(org,2) %go through columns
    for row = 1:size(org,1) %go through rows
        pixel = org(row,col,:);
        lab = xyz2lab([pixel(1,1,1) pixel(1,1,2) pixel(1,1,3)]);
        
        tmp = inf;
        for i = 1:size(IMAGES,2)
            dE(i) = sqrt(sum((lab - IMAGES{2,i}).^ 2));
            if (dE(i) < tmp)
                tmp = dE(i);
                id = i;
            end
        end

        % Error diffusion, spread the error to surrounding pixels
        patch = lab2xyz(IMAGES{2,id});
        for i = 1:3
            qerror = pixel(1,1,i) - patch(i);

            if(col < size(org,2))
               org(row,col+1,i) =  ((7/16 *qerror)+org(row,col+1,i)); 
            end
            if(row < size(org,1)) 
               org(row+1,col,i) = org(row+1,col,i) + (5/16 *qerror);
            end
            if(row < size(org,1) && col > 1)
                org(row+1,col-1,i) = org(row+1,col-1,i) + (3/16 *qerror);
            end
            if(col < size(org,2) && row < size(org,1))
               org(row+1,col+1,i) = org(row+1,col+1,i) + (1/16 *qerror);
            end
        end

%         org = errorDiffusion(org, col, row, IMAGES{2,id});
        res(1+(row-1)*patchSize:(row-1)*patchSize+patchSize,...
            1+(col-1)*patchSize:(col-1)*patchSize+patchSize,:) = IMAGES{1,id};
    end
end
imshow(res);
kitten_errordif = res;
save('kitten_errordif', 'kitten_errordif');
