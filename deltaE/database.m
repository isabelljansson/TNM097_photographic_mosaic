N = 90;
IMAGES = cell(2,N);

%Load images
patchSize = 10;
j = 0;
x=9999999;
y=x;
for i = 30000:30000 + N-1;
    j = j + 1;
     img = im2double(imread(sprintf('images/%d.jpg', i)));close
     if(x > size(img,1))
         x = size(img,1);
     end
     if(y > size(img,2))
         y = size(img,2);
     end
     IMAGES{1,j} = img;
end

%crop images to equal sizes

for i = 1:N
    img = IMAGES{1,i};
    
    %Crop to minimum common size
    img = img(floor(size(img,1)/2 - x/2)+1: floor(size(img,1)/2 + x/2) ...
          , floor(size(img,2)/2 - y/2)+1:floor(size(img,2)/2 + y/2),:);
    croped = imresize(img,[patchSize,patchSize], 'bicubic');
    
    xyz = rgb2xyz(croped);
    xo = xyz(:,:,1);
    yo = xyz(:,:,2);
    zo = xyz(:,:,3);
    xyzm(1) = mean(xo(:));
    xyzm(2) = mean(yo(:));
    xyzm(3) = mean(zo(:));
    lab = xyz2lab(xyzm);
    
    IMAGES{1,i} = croped; %original
    IMAGES{2,i} = lab;
end

save('images', 'IMAGES')