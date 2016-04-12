N = 1110;
IMAGES = cell(2,N);

%Load images
patchSize = 20;
j = 0;
x=9999999;
y=x;

for i = 1:N;    
     img = im2double(imread(sprintf('emojis/%d.jpg', i)));
     if( size(img,3) ~= 3)
         img(:,:,2) = img(:,:,1);
         img(:,:,3) = img(:,:,1);
     end

     IMAGES{1,i} = img;
end

%crop images to equal sizes

for i = 1:N
    img = IMAGES{1,i};
    %img = img(floor(size(img,1)/2 - x/2)+1: floor(size(img,1)/2 + x/2) ...
    %     , floor(size(img,2)/2 - y/2)+1:floor(size(img,2)/2 + y/2),:);
    croped = imresize(img,[patchSize,patchSize], 'bicubic');
    
    IMAGES{1,i} = croped;
    IMAGES{2,i} = rgb2xyz(croped);
end

save('images', 'IMAGES')