clear; clc; close all;
%% Read Images
 target = imread("target.png");
 crystals = imread("crystal.png");
 lena = imread("Lena.png");
 target_img = double(rgb2gray(target));
 lena_img = double(lena);
 crystals_img =double(rgb2gray(crystals));
 before_filtered = {target, crystals,lena};
 images = {target_img,crystals_img,lena_img};
 labels = {"Target Image", "Crystals Image", "Lena Image"};

%% Part a- Write a MATLAB program that performs and displays X and Y directed Sobel edge
% detection on three images.
% Create sobel filters
sobel_horizontal = [-1 -2 -1
               0 0  0
               1 2  1];
sobel_vertical = transpose(sobel_horizontal);
filtered_images = {};
filtered_labels = {};
for i=1:length(images)
    %Use imfilter
    filtered_images{length(filtered_images)+1} = before_filtered{i};
      filtered_labels {length(filtered_labels)+1} = labels{i};
    horizontal_gradient = imfilter(images{i},sobel_horizontal);
    vertical_gradient = imfilter(images{i},sobel_vertical);
    filtered_images{length(filtered_images)+1} = horizontal_gradient;
    filtered_labels {length(filtered_labels)+1} = labels{i} + " Horizontal Gradient";
    filtered_images{length(filtered_images)+1} = vertical_gradient;
    filtered_labels {length(filtered_labels)+1} = labels{i} + " Vertical Gradient";    
end
showImages(filtered_images,filtered_labels,"Q3_Resulting_Images/a","Sobel Edge Detections",3,3)

%% Part b- Write a MATLAB program that performs and displays |Gx| + |Gy| edge detection on three
% images.
abs_gradient_sum = {};
abs_gradient_sum_labels = {};
for i=1:length(images)
    horizontal_gradient_img = filtered_images{3*i-1};
    vertical_gradient_img = filtered_images{3*i};
    abs_sum_img = abs(horizontal_gradient_img+vertical_gradient_img);
    abs_gradient_sum{length(abs_gradient_sum)+1} = before_filtered{i};
    abs_gradient_sum{length(abs_gradient_sum)+1} = abs_sum_img;
    abs_gradient_sum_labels{length(abs_gradient_sum_labels)+1} = labels{i};
    abs_gradient_sum_labels{length(abs_gradient_sum_labels)+1} = labels{i} + " |Gx|+|Gy|";
end
showImages(abs_gradient_sum,abs_gradient_sum_labels,"Q3_Resulting_Images/b","Sum of Gradients",3,2)

%% Part c- Write a MATLAB program that performs and displays magnitude gradient edge detection
% on three images.
magnitude= {};
magnitude_labels = {};
for i=1:length(images)
    horizontal_gradient_img = filtered_images{3*i-1};
    vertical_gradient_img = filtered_images{3*i};
    magnitude_img = sqrt(double(horizontal_gradient_img.^2+vertical_gradient_img.^2));
    magnitude{length(magnitude)+1} = before_filtered{i};
    magnitude{length(magnitude)+1} = magnitude_img;
    magnitude_labels{length(magnitude_labels)+1} = labels{i};
    magnitude_labels{length(magnitude_labels)+1} = labels{i} + "-Magnitude";
end
showImages(magnitude,magnitude_labels,"Q3_Resulting_Images/c","Magnitude Gradient Edge Detection",3,2)


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


