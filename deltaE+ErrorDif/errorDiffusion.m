function [ res ] = errorDiffusion( org, col, row, labPatch )
% Error diffusion for spreading the error in a pixel to the three
% surrounding pixels
% Matlab Implementation of Error diffusion using Floyd's and Steinberg's...
% filter weights.

% error=ones(s(1),s(2));
xyzPixel = org(row,col,:);
xyzPatch = lab2xyz(labPatch);

res = org;

for i = 1:3
    qerror = xyzPixel(1,1,i) - xyzPatch(i);

    if(col < size(org,2))
       res(row,col+1,i) =  ((7/16 *qerror)+org(row,col+1,i)); 
    end
    if(row < size(org,1)) 
       res(row+1,col,i) = org(row+1,col,i) + (5/16 *qerror);
    end
    if(row < size(org,1) && col > 1)
        res(row+1,col-1,i) = org(row+1,col-1,i) + (3/16 *qerror);
    end
    if(col < size(org,2) && row < size(org,1))
       res(row+1,col+1,i) = org(row+1,col+1,i) + (1/16 *qerror);
    end
end


