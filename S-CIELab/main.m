load images;
load id;

orgHeight = size(IMAGES{1,1},1);
orgWidth = size(IMAGES{1,1},2);

patchSize = size(IMAGES{1,1},2);
len = patchSize*(orgWidth/patchSize)*(orgHeight/patchSize);
res = zeros(patchSize, len,3);
j = 0;
for i = 1:patchSize:len-patchSize
   j = j + 1;
 
   res(1:patchSize,i:i+patchSize-1,:) = IMAGES{1,id(j)};
end

kitten = reshapeInv( res, orgWidth, orgHeight);

imshow(kitten);
save('kitten_scielab', 'kitten')