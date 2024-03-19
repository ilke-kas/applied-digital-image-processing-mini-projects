clear; clc; close all;

%% Part a- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image of constant intensity 60
image_a = uint8(ones(500,500)*60);

%% Part b- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with alternating black and white vertical stripes, each of which is 2
% pixels wide.
image_b = uint8(repmat([zeros(500,2) ones(500, 2)],(500/4)));

%% Part c- Create the following 500 × 500 8-bit images in MATLAB:  A grayscale image where the left half has intensity 32 and the right half has intensity 200.
image_c = uint8([32*ones(500,250) 200*ones(500,250)]);

%% Part d- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with a ramp intensity distribution, described by I(x, y) = 0.5x
[X,Y] = meshgrid(1:500,1:500);
image_d = uint8(0.5*Y);

%% Part e- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with a Gaussian intensity distribution centered at (64, 64), described by the function given
[X,Y] = meshgrid(1:500,1:500);
image_e = uint8(255 * exp(-1* ((X-64).^2 + (Y-64).^2)/ 200^2));

%% Part f- Create the following 500 × 500 8-bit images in MATLAB: A color image where the upper left quadrant is white, the lower left quadrant is magenta,
% the upper right quadrant is cyan, and the lower right quadrant is blue.
white = ones(125,125,3)*255
magenta = cat(3, ones(125,125)*255, zeros(125,125), ones(125,125)*255);
cyan = cat(3, zeros(125,125),ones(125,125)*255,  ones(125,125)*255);
blue =  cat(3, zeros(125,125),zeros(125,125),  ones(125,125)*255);
image_f = [ white,cyan; magenta,blue];

%% Display Images
images = {image_a, image_b, image_c, image_d, image_e,image_f};
labels = {'Image A','Image B','Image C','Image D','Image E','Image F'};
showImages(images,labels,"Q1_Resulting_Images","Q1 Images",3,3);

%% This function will display the images and their histograms
function showImages(images, labels, file_name, final_image_name, subplot_x,subplot_y)
%Display the Images 
    figure
    for i=1:length(images)
        currentImage = images{i};
        % Create a subplot
        subplot(subplot_x, subplot_y, i);
        % Display the image with its label
        imshow(currentImage, []);
        % Compute the noise standard deviation and mean before and after filtering. 
        title(labels{i} + " mean:" + mean2(currentImage) + " std: " + std2(currentImage));
        imwrite(mat2gray(currentImage),fullfile(file_name, labels{i}+".jpg"));
    end
    % Adjust layout
    sgtitle(final_image_name + "-Images");
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end