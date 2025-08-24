clear; clc; close all;
% Create gaussian kernel
h = fspecial('gaussian', [3 3],1)

h1 = conv2(h,h)
h2 = conv2(h, h1)
h3 = conv2(h,h2)

%standard deviation part


