function [patches_ind] = lb2patches(I, patchSize, stride)



    strideY = stride;
    strideX = stride;
    patchWidth = patchSize(1);
    patchHeight = patchSize(2);
    [hin,win,~] = size(I); 
    din = 1;
    hout = hin ; %- mod(hin-patchHeight,strideY) + strideY*(strideY > 1);
    wout = win ; %- mod(win-patchWidth, strideX) + strideX*(strideX > 1);
    nPixelsPerPatch = patchWidth * patchHeight * din;
    
    % x-y indices for a single (possibly N-dimensional) patch 
    [x,y,~] = meshgrid(1:patchWidth,1:patchHeight,1:din);
    % pixel indices for all patches
    
    
    
    [xstart,ystart] = meshgrid(0:strideX:(wout-patchWidth),0:strideY:(hout-patchHeight));
    inds    = bsxfun(@plus, reshape(y,nPixelsPerPatch,[]), ystart(:)');
    inds    = inds + (bsxfun(@plus, hout*reshape(x-1,nPixelsPerPatch,[]), hout*xstart(:)')); 
    inds = bsxfun(@plus, inds, hin * win * (0:size(inds, 2) - 1));
    
    patches_ind = reshape(inds,patchHeight,patchWidth,din,[]);




