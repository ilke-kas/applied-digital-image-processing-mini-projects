clear; clc; close all;
% Read the image
finger_print_img = imread("finger_print.tif");
text_img = imread("text.tif");
city_img = imread("city.tif");

%% Part a- Using the finger_print.tif image, apply any combination of the morphological operations
% to clean the image

%% Part b- Using the text.tif image, apply any combination of the morphological operations to clean
% the image

%% Part c- Using the city.tif image, apply morphological gradient and display the resulting image.


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