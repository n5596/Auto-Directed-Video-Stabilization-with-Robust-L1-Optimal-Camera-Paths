clc;
close all;
clear all;

%-------FINDING B(i) WHICH WILL CONVERT CAMERA PATH TO OPTIMAL PATH---
x = importdata('C:\CVIT\Practice\Pictures\Shaky\skateX.mat');
y = importdata('C:\CVIT\Practice\Pictures\Shaky\skateY.mat');
opX = importdata('C:\CVIT\Practice\Pictures\Shaky\skateopX.mat');
opY = importdata('C:\CVIT\Practice\Pictures\Shaky\skateopY.mat');
theta = importdata('C:\CVIT\Practice\Pictures\Shaky\skateTheta.mat');
opTheta = importdata('C:\CVIT\Practice\Pictures\Shaky\skateopTheta.mat');
scale = importdata('C:\CVIT\Practice\Pictures\Shaky\skateScale.mat');
opScale = importdata('C:\CVIT\Practice\Pictures\Shaky\skateopScale.mat');
C = importdata('C:\CVIT\Practice\Pictures\Shaky\skateC.mat');

num = size(x);
num = num(1);

for i = 1:num
    sc = opScale(i)*cos(opTheta(i));
    ss = opScale(i)*sin(opTheta(i));
%     T = [1 0 0;0 1 0;opX(i) opY(i) 1];
    T = [sc -ss 0;ss sc 0;opX(i) opY(i) 1];
    opT(i) = affine2d(T);
end

for i = 1:num
    Ti = opT(i).T;
    Ci = C(i).T;
    Bi = inv(Ci)*Ti;
%     Bi(1:2,3) = 0;
%     Bi(3,3) = 1;
    Bi = inv(Bi);
    Bi(1:2,3) = 0;
    Bi(3,3) = 1;
    B(i) = affine2d(Bi);
end

im1 = imageDatastore(fullfile('C:','CVIT','Practice','Pictures','ShakyImages', 'Skate'), 'LabelSource', 'foldernames');
img1 = readimage(im1,1);
[h, w, s] = size(img1);

for i = 1:num
    disp(i);
    img = readimage(im1, i);
    warp = B(i);
%         R=imref2d(size(img),[1 size(img,2)],[1 size(img,1)]);
    R = imref2d(size(img));
    imgT=imwarp(img,R, warp,'OutputView',R);
%     imgT = imwarp(img, warp);
    imgW = imcrop(imgT, [0.15*w 0.15*h 0.7*w-1 0.7*h-1]);
    imwrite(imgW,['C:\CVIT\Practice\Pictures\Shaky\skate\img',num2str(i, '%04d'),'.png']); 
end
    
