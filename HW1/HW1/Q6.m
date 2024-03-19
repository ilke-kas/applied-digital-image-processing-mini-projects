clear; clc; close all;
% Create kernel and the image
f = ones(5,5);
w = [1 2 1
    2 4 2
    1 2 1];
%Convolve these two
conv_result = conv2(f,w)
%Check bias
sum_f = sum(f(:))
sum_conv_result = sum(w(:))

if sum_f == sum_conv_result
    disp(['the sum of the pixels in the original and filtered images were the same,' ...
        ' thus preventing a bias from being introduced by filtering'])
else
    disp(['the sum of the pixels in the original and filtered images were not the same' ...
        ', thus have a bias from being introduced by filtering'])
end

