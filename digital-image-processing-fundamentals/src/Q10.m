clear; clc; close all;
%Read gaussian noise image
img = imread("unsharp_masking.png");
if size(img, 3) == 3
    img = rgb2gray(img);
end
% Normal unsharp masking
% Blur image
h = createAveragingKernel(3)
blurred_img = conv2(img,transpose(h), 'same');

%Add the mask to the original image
unsharpening = img+(img-uint8(blurred_img));

figure
imshow(unsharpening);

% find the fft of the kernel 
fft_h = fft2(h)
I = [1 0 0; 0 1 0; 0 0 1]
h_one_pass_fft = 2*I-fft_h
f_one_pass = ifft2(h_one_pass_fft)

%perform Unsharpening in single pass
unsharpening_single = imfilter(img,f_one_pass);

figure
imshow(unsharpening_single,[]);

%% This function will take kernel size and create averaging kernel
function averaging_kernel = createAveragingKernel(kernel_size)
    averaging_kernel = ones(kernel_size,kernel_size) * (1/(kernel_size^2));
end