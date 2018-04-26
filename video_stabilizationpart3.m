clc;
close all;
clear all;

%-------OPTIMIZING THE CAMERA PATH-------
Tform = importdata('C:\CVIT\Practice\Pictures\Shaky\skateC.mat');
num = size(Tform);
num = num(2);
x = zeros(num, 1);
y = zeros(num, 1);
scale = zeros(num, 1);
theta = zeros(num, 1);

for i = 1:num
    sc = Tform(i).T(1,1);
    ss = Tform(i).T(2,1);
    x(i) = Tform(i).T(3,1);
    y(i) = Tform(i).T(3,2);
    scale(i) = sqrt(sc*sc + ss*ss);
    theta(i) = (atan(ss/sc));
end

N = num;
e = ones(N,1);
lambda1 = 10000;
lambda2 = 10000;
lambda3 = 20000;
D1 = spdiags([-e e], 0:1, N-1, N);
D2 = spdiags([e -2*e e], 0:2, N-2, N);
D3 = spdiags([-e 3*e -3*e e], 0:3, N-3, N);
% figure, plot(x);
% view(-90,90);
% title('x');
% figure, plot(y);
% view(-90,90);
% title('y');
% figure, plot(theta);
% view(-90,90);
% title('theta');
% figure, plot(scale);
% view(-90,90);
% title('scale');

img = imread('C:\CVIT\Practice\Pictures\ShakyImages\Skate\img0001.png');
[h, w, s] = size(img);

Ya = x;
Yb = y;
Yc = scale;
Yd = theta;
cvx_begin
    variable X1(1*N)
    variable Y1(1*N)
    variable T1(1*N)
    variable S1(1*N)
    minimize(0.5*sum_square(Ya(1:N)-X1) +  ...
    + lambda1*norm(D1*X1,1) + lambda2*norm(D2*X1,1) + lambda3*norm(D3*X1,1) + ...
    + 0.5*sum_square(Yb(1:N)-Y1) + lambda1*norm(D1*Y1,1) + lambda2*norm(D2*Y1,1) + lambda3*norm(D3*Y1,1) + ...
    + 0.5*sum_square(Yc(1:N)-S1) + lambda1*norm(D1*S1,1) + lambda2*norm(D2*S1,1) + lambda3*norm(D3*S1,1) + ...
    + 0.5*sum_square(Yd(1:N)-T1) + lambda1*norm(D1*T1,1) + lambda2*norm(D2*T1,1) + lambda3*norm(D3*T1,1)...
    )
    subject to
    -0.1*w <= X1-x <= 0.1*w
    -0.1*h <= Y1-y <= 0.1*h
    -0.01 <= S1-scale <= 0.01
    -0.005 <= T1-theta <= 0.005
cvx_end

save('C:\CVIT\Practice\Pictures\Shaky\skateX.mat', 'x');
save('C:\CVIT\Practice\Pictures\Shaky\skateY.mat', 'y');
save('C:\CVIT\Practice\Pictures\Shaky\skateopX.mat', 'X1');
save('C:\CVIT\Practice\Pictures\Shaky\skateopY.mat', 'Y1');
save('C:\CVIT\Practice\Pictures\Shaky\skateTheta.mat', 'theta');
save('C:\CVIT\Practice\Pictures\Shaky\skateopTheta.mat', 'T1');
save('C:\CVIT\Practice\Pictures\Shaky\skateScale.mat', 'scale');
save('C:\CVIT\Practice\Pictures\Shaky\skateopScale.mat', 'S1');

figure, plot (x);
hold on; 
plot(X1);
view(-90, 90);
legend('x', 'x op');
xlim([0 num]);
title('X');
figure,  plot(y);
hold on;
plot(Y1);
view(-90, 90);
legend('y', 'y op');
xlim([0 num]);
title('Y');
figure,  plot(scale);
hold on;
plot(S1);
view(-90, 90);
legend('scale', 'sc op');
xlim([0 num]);
title('S');
figure,  plot(theta);
hold on;
plot(T1);
view(-90, 90);
legend('t', 't op');
xlim([0 num]);
title('T');

