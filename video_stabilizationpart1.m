clc;
clear all;
close all;

%--------COMPUTE THE FRAME TRANSFORMS MAPPING IMAGE I TO I-1-------
im1 = imageDatastore(fullfile('C:','CVIT','Practice','Pictures','ShakyImages', 'Skate'), 'LabelSource', 'foldernames');
numImages = length(im1.Files);
aspectratio = 1.778;

numImages = 1000;
for i = 2:numImages
    img1 = readimage(im1,i);
    img2 = readimage(im1,i-1);
    i1 = rgb2gray(im2single(img1));
    i2 = rgb2gray(im2single(img2));
    [f1, d1] = vl_sift(i1);
    [f2, d2] = vl_sift(i2);
    match = vl_ubcmatch(d1, d2);
    tform = estimateGeometricTransform(transpose(f1(1:2,match(1,:))), transpose(f2(1:2,match(2,:))),'similarity');
    F(i) = tform;
end
    
save('C:\CVIT\Practice\Pictures\Shaky\skateTformnew.mat', 'F');
% save('C:\CVIT\Practice\Pictures\Shaky\skateC.mat', 'C');
