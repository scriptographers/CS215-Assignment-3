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

e = z - a*x - y*b - c; % error values with mu
variance = sum(e.^2)/len; % Using ML of Gaussian to find variance
% variance = var(e);

fprintf('Predicted plane equation : z = %fx + %fy + %f\n', a, b, c);
fprintf('Noise Variance : %f', variance);
