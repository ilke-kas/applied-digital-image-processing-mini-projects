clear; clc; close all;
% Read the image
finger_print_img = imread("finger_print.tif");
text_img = imread("text.tif");
city_img = imread("city.tif");

%% Part a- Using the finger_print.tif image, apply any combination of the morphological operations
% to clean the image
SE= strel('disk',3)
opened_img = imopen(finger_print_img,SE)
closing_opened_img = imclose(opened_img, SE)
images_a = {finger_print_img, opened_img, closing_opened_img};
labels_a = {"Original Image", "Opened Image", "Closing of Openning Image"};
showImages(images_a, labels_a, "Q9_Resulting_Images/a","Finger Print", 1, 3);

%% Part b- Using the text.tif image, apply any combination of the morphological operations to clean
% the image
% Perform morphological closing to fill holes
SE= strel('disk',1)
opened_img = imopen(text_img,SE)
SE2= strel('disk',3)
closing_opened_img = imclose(opened_img, SE2)
images_b = {text_img, opened_img, closing_opened_img};
labels_b = {"Original Image", "Opened Image", "Closing of Openning Image"};
showImages(images_b, labels_b, "Q9_Resulting_Images/b","Text Image", 1, 3);

%% Part c- Using the city.tif image, apply morphological gradient and display the resulting image.
SE= strel('disk',3);
dilated_img = imdilate(city_img,SE);
eroded_img = imerode(city_img,SE);
gradient = dilated_img - eroded_img;
images_c = {city_img, dilated_img, eroded_img, gradient};
labels_c = {"Original Image", "Dilated Image", "Eroded Image", "Gradient"};
showImages(images_c, labels_c, "Q9_Resulting_Images/c","City Image", 2, 2);


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