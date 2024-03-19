clear; clc; close all;

% Read the image
img = imread('intensity_spread.png');

% Convert the image to grayscale if it's not already grayscale
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Display the original image and its histogram
figure
subplot(1,3,1)
imshow(img)
title('Original Image')
subplot(1,3,2:3)
imhist(img)
title('Histogram')

% Apply intensity stretching
L = 90;
min_intensity = min(img(:));
max_intensity = max(img(:));

img_stretched =  (img - min_intensity) * ((L-1) / (max_intensity - min_intensity));


% Display the stretched image and its histogram
figure
subplot(1,3,1)
imshow(uint8(img_stretched)) % Convert back to uint8 for imshow
title('Stretched Image')
subplot(1,3,2:3)
imhist(uint8(img_stretched)) % Convert back to uint8 for imhist
title('Stretched Histogram')
