clc;
close all;
clear all;

%-------COMPUTE CAMERA PATH C(i)=C(i-1)F(i)------
tform = importdata('C:\CVIT\Practice\Pictures\Shaky\skateTform.mat');
num = size(tform);
num = num(2);

 C(1) = tform(1);

for i = 2:num
    b = C(i-1);
    c = b.T*tform(i).T;
    d = affine2d(c);
    C(i) = d;
end
save('C:\CVIT\Practice\Pictures\Shaky\skateC.mat', 'C');

    
