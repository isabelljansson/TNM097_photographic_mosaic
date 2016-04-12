load images;

addpath('include');
% Sample per degree
ppi = 120;
distance = 500 / 25.4;
sampPerDeg = ppi * distance * tan(pi/180);
wp = [95.047 100.00 108.883];

% orgHeight = 720;
% orgWidth = 1020;

org = im2double(imread('happy_dog.jpg'));
%imshow(org)
orgHeight = size(org, 1);
orgWidth = size(org, 2);
%org = imresize(org, [orgHeight,orgWidth]);

org_xyz = rgb2xyz(org);

patchSize = size(IMAGES{1,1},2);
len = patchSize*(orgWidth/patchSize)*(orgHeight/patchSize);

orgReshape = reshapImg( org_xyz, patchSize);

j = 0;

%patch = orgReshape(1:patchSize,1:1+patchSize-1,:);
%scie = scielab(sampPerDeg, patch, IMAGES{2,1}, wp, 'xyz');
x = inf;
for i = 1:patchSize:len-patchSize
   j = j + 1; 
   patch = orgReshape(1:patchSize,i:i+patchSize-1,:);
   
   for k = 1:size(IMAGES,2)
        tmp = scielab(sampPerDeg, patch, IMAGES{2,k}, wp, 'xyz');
        scie = mean(tmp(:));
        if(scie < x)
            id(j) = k;
            x = scie;
        end
   end
   x = inf;
end

save('id','id')

