clear; clc; close all;
%Create a 2D image which have a flat background of 50
img = ones(500,500) * 50
%image containing Gaussian noise with a standard deviation of 30 gray-scale values
% Generate Gaussian noise
noise = 30 * randn(500);
% Add noise to the background
noise_img = img + noise;

%% Part a- Filter the image using a 5x5 averaging filter. Show the images before and after. 
% Compute the noise standard deviation and mean before and after filtering. Create a histogram
% in MATLAB for both images and compare them. Compare your standard deviation result to the theoretical
% estimate of Gaussian white noise variance after average filtering with a 5x5 kernel, using information
% given in the lecture.

%Lets filter the image using a 5x5 averaging filter
averaging_kernel_5 = createAveragingKernel(5)
%Apply averaging kernels
averaging_img_5 = imfilter(noise_img, averaging_kernel_5);
%Show the images before and after
images = {noise_img, averaging_img_5}
labels = {'Image with Gaussian Noise','Image Filtered by 5x5 Averaging Kernel' }

%Look this function for Part A
showImages(images,labels, 'Q3_Resulting_Images', 'Averaging by 5x5 -Part a',1,2)

%% Part b- Take the output image from (a) and filter it again with the 5x5 averaging filter. 
% What is the standard deviation? Compare the result to the theory from (a). 
% Give a rationale for any deviation from the simple theory.
averaging_img_5_b =  imfilter(averaging_img_5,averaging_kernel_5);
images{end+1} = averaging_img_5_b
labels{end+1} = 'Image Filtered by 5x5 Averaging Kernel Twice'
showImages(images,labels, 'Q3_Resulting_Images', 'Averaging by 5x5 -Part b',1,3)

%% Part c- Filter the original image with a 5x5 median. Show the result images before and after.
% Compute the standard deviation of the noise before and after filtering.
median_img = medfilt2(noise_img, [5, 5]);
images{end+1} = median_img
labels{end+1} = 'Image Filtered by 5x5 Median'
% Part c & d
showImages(images,labels, 'Q3_Resulting_Images', 'Averaging by 5x5 -Part c and d',2,2)

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
    sgtitle(final_image_name);
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end


%% This function will take kernel size and create averaging kernel
function averaging_kernel = createAveragingKernel(kernel_size)
    averaging_kernel = ones(kernel_size,kernel_size) * (1/(kernel_size^2));
end