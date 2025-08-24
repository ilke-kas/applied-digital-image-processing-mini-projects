clear; clc; close all;
% Read the image
img = imread('histogram_equalization.png');
%Convert the image to the grayscale
if size(img, 3) == 3
    img = rgb2gray(img);
end

% Adjust the contrast using histogram equalization.
% Use the default behavior of the histogram equalization function, histeq.
% The default target histogram is a flat histogram with 64 bins.
equalized_img = histeq(img);

% Second pass on the histogram-equalized image
second_pass_equalized_img = histeq(equalized_img);

images = {img,equalized_img,second_pass_equalized_img};
labels = {"Original Image", "Image After Histogram Equalization", "Second Pass on the Histogram Equalized Image"};

showImages(images, labels, "Q5_Resulting_Images", "Histogram Equalization", 1,3)

% Compare the second pass and first pass after histogram equalization
is_same_img = (equalized_img == second_pass_equalized_img);
if is_same_img
    disp(" second pass of histogram equalization (on the histogram-equalized image) ..." + ...
        " will produce exactly the same image as the first pass ")
else
    disp(" second pass of histogram equalization (on the histogram-equalized image) ..." + ...
        " will not produce exactly the same image as the first pass ")
end

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
    figure
    for i=1:length(images)
        currentImage = images{i};
        % Create a subplot
        subplot(subplot_x, subplot_y, i);
        % Create histogram for both images
        histogram(currentImage, 'Normalization','count');
        title(labels{i});
        imwrite(mat2gray(currentImage),fullfile(file_name, labels{i}+".jpg"));
    end
    % Adjust layout
    sgtitle(final_image_name+"-Histograms");
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end