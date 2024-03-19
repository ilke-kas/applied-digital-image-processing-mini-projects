clear; clc; close all;

%% Part a- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image of constant intensity 60
image_a = uint8(ones(500,500)*60);
figure
imshow(image_a, [])

%% Part b- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with alternating black and white vertical stripes, each of which is 2
% pixels wide.
image_b = uint8(repmat([zeros(500,2) ones(500, 2)*255],[1 125]));
figure
imshow(image_b, [])

%% Part c- Create the following 500 × 500 8-bit images in MATLAB:  A grayscale image where the left half has intensity 32 and the right half has intensity 200.
image_c = uint8([32*ones(500,250) 200*ones(500,250)]);
figure
imshow(image_c, [])

%% Part d- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with a ramp intensity distribution, described by I(x, y) = 0.5x
[X,Y] = meshgrid(1:500,1:500);
image_d = uint8(0.5*Y);
figure
imshow(image_d, [])

%% Part e- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with a Gaussian intensity distribution centered at (64, 64), described by the function given
[X,Y] = meshgrid(1:500,1:500);
image_e = uint8(255 * exp(-1* ((X-64).^2 + (Y-64).^2)/ 200^2));
figure
imshow(image_e, [])

%% Part f- Create the following 500 × 500 8-bit images in MATLAB: A color image where the upper left quadrant is white, the lower left quadrant is magenta,
% the upper right quadrant is cyan, and the lower right quadrant is blue.
white = ones(250,250,3)*255;
magenta = cat(3, ones(250,250)*255, zeros(250,250), ones(250,250)*255);
cyan = cat(3, zeros(250,250),ones(250,250)*255,  ones(250,250)*255);
blue =  cat(3, zeros(250,250),zeros(250,250),  ones(250,250)*255);
image_f = [ white,cyan; magenta,blue];
figure
imshow(image_f, [])