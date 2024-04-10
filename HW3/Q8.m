clear; clc; close all;
% Read the image
noisy_img = imread("NoisyImg.bmp");
% This is a 256-level gray image of a truck in a desert which has been corrupted by noise. First,
% apply median filtering to the given image and save the restored image as Median.bmp. Next,
% apply adaptive Wiener filtering to the given image and save the restored image as Wiener.bmp.
% Implement adaptive median filtering and apply it to the given image, and save the restored
% image as AdaptiveMedian.bmp. Devise your own technique by combining two or more of the
% previous techniques to improve the quality of the restoration. Compare and contrast your result
% with the previous three, and save the restored image as ResultA.bmp. Here are some helpful
% MATLAB methods: wiener2 (Adaptive Wiener filtering), medfilt2 (2D median filtering),
% ordfilt2 (2D order-statistic filtering), fspecial(%disk , 3) (Blurring filter), imfilter, conv2, filter2
% (Apply a 2D-filter to an image)



%% This function will display the images 
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
        title(labels{i});
        imwrite(mat2gray(currentImage),fullfile(file_name, labels{i}+".jpg"));
    end
    % Adjust layout
    sgtitle(final_image_name + "-Images");
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end