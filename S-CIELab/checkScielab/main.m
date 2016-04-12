addpath('../include');

% load kitten_scielab;
% res1 = kitten;
load dog_de_01;
res2 = kitten_dE;
load dog_errordif_01;
res3 = kitten_errordif;

org = im2double(imread('kitten.jpg'));
% org1 = imresize(org, [size(res1,1),size(res1,2)], 'bicubic');
org2 = imresize(org, [size(res2,1),size(res2,2)], 'bicubic');
org3 = org2;

patchsize = 20;
dp = sqrt(1020^2 + 720^2);
di = 72; %projector

ppi = (dp/di)/patchsize;
distance = 4000;
sampPerDeg = ppi * distance * tan(pi/180);
wp = [95.047 100.00 108.883];

%convert to xyz
% xyz1 = rgb2xyz(res1);
xyz2 = rgb2xyz(res2);
xyz3 = rgb2xyz(res3);

% xyzo1 = rgb2xyz(org1);
xyzo2 = rgb2xyz(org2);
xyzo3 = rgb2xyz(org3);

% scie1 = scielab(sampPerDeg, xyz1, xyzo1, wp, 'xyz');
scie2 = scielab(sampPerDeg, xyz2, xyzo2, wp, 'xyz');
scie3 = scielab(sampPerDeg, xyz3, xyzo3, wp, 'xyz');

% scie1 = mean(scie1(:))
scie2 = mean(scie2(:))
scie3 = mean(scie3(:))