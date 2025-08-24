clear; clc; close all;
% Read the image
img = imread('shading.png');
%Convert the image to the grayscale
if size(img, 3) == 3
    img = rgb2gray(img);
end
img = imresize(img, [2048 2048])

% Number of times to tile the image
num_rows = 3; % Number of times to tile along rows
num_cols = 4; % Number of times to tile along columns

% Tile the image
tiled_img = repmat(img, [num_rows, num_cols]);

% Create large gaussian kernel
h = fspecial('gaussian', [512 512],128);

%Filter image
filtered_img = conv2(tiled_img, h, 'valid' );

images = {tiled_img,filtered_img, filtered_img(1:632,1:636)};
labels = {"Original Image", "Filtered image", 'One Image'};

showImages(images, labels, "Q8_Resulting_Images", "Shading Pattern", 1,3)


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