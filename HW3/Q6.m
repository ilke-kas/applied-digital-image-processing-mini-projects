clear; clc; close all;
% Read the image
circle_img = imread('Circles.png');
circle_img = im2gray(circle_img);

% Consider the image Circles.png.
% There are many special uses of erosion. One of the most common application using the erosion is
% to separate the touching objects in a binary image so that can be counted using a labeling
% algorithm. In this section just use the erosion method to display the circles in the image
% distinctly. The image shows a number of dark disks against a light background.
%% Part a- Do a thresholding of this image.
level = graythresh(circle_img);
thresholded_img = imbinarize(circle_img,level);
%% Part b-Then use the erosion operation to display the circles distinctly in the image.
SE = strel('disk',11);
eroded_img = imerode(circle_img,SE);

%% Part c- Show your output from each step.
images = {circle_img, thresholded_img,eroded_img};
labels = {"Original Image","Thresholded Image","Eroded Image"};
showImages(images, labels, "Q6_Resulting_Images", "Seperate Touching Objects", 1,3);

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