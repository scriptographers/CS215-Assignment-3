clear;
close all;
clc;

coord = dlmread("./XYZ.txt"); % Read the file
x = coord(:,1); % X-coordinates
y = coord(:,2); % Y-coordinates
z = coord(:,3); % Z-coordinates
len = length(x); % Number of points

% Solving for a, b, c
sumx = sum(x,1);
sumy = sum(y,1);
sumz = sum(z,1);
sumx2 = sum(x.*x,1);
sumy2 = sum(y.*y,1);
sumxy = sum(x.*y,1);
sumzx = sum(z.*x,1);
sumzy = sum(z.*y,1);
ret = [sumx2 sumxy sumx; sumxy sumy2 sumy; sumx sumy len;]\[sumzx; sumzy; sumz;];

a = ret(1,1); % a
b = ret(2,1); % b
c = ret(3,1); % c

e = z - a*x - y*b - c; % error values
sigma = std(e); % sigma

fprintf('Predicted plane equation : %fx + %fy + %f = 0\n', a, b, c);
fprintf('Standard Deviation : %f', sigma);
