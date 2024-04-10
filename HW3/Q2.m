clear; clc; close all;
%Read gaussian noise image
edges_gnoise = imread("Edges_gnoise.tif");
%Read salt an pepper noise image
edges_spnoise = imread("Edges_spnoise.tif");

%Use the function you defined to remove the noise from images by usin
%averaging, median and wiener filtering for both gaussian and salt and
%pepper noisy images
remove_noise_from_img(edges_gnoise, 'Gaussian Noise')
remove_noise_from_img(edges_spnoise, 'Salt and Pepper Noise')


%% This function will take image and image name as input
% It will displayed the image filtered by using averaging, median and wiener
function remove_noise_from_img(image, img_name)
    %Create Averaging Kernel
    averaging_kernel_3 = createAveragingKernel(3);
    averaging_kernel_9 = createAveragingKernel(9);
    
    %Apply averaging kernels
    averaging_img_3 = imfilter(image, averaging_kernel_3);
    averaging_img_9 = imfilter(image, averaging_kernel_9);
    
    %Median Filtering with 3x3 kernel
    %Since medfilt2 function does not take 3 dimensional images, we will loop
    %for each dimension and filter like that
    for c = 1 : 3
        median_img(:, :, c) = medfilt2(image(:, :, c), [3, 3]);
    end

    %Wiener Filtering Image
    %Since wiener2 function does not take 3 dimensional images, we will loop
    %for each dimension and filter like that
    for c = 1 : 3
          %According to MATLAB documentation, if we are not giving
          %estimated noise, wiener2 will use the mean of the local variance
          %of the pixels. I wanted the check that value first
         [wiener_img(:, :, c),noise_out] = wiener2(image(:, :, c), [3, 3]);
         disp("Estimated Noise By Wiener 2 Function" +noise_out);
         %I gave noise estimation 5 times of that estimation to
         %understand its effect
         wiener_img2(:, :, c) = wiener2(image(:, :, c), [3, 3],noise_out*5);
         wiener_img3(:, :, c) = wiener2(image(:, :, c), [5, 5],noise_out*5);
    end

    %Display the Images 
    images = {image, averaging_img_3, averaging_img_9, median_img, wiener_img, wiener_img2, wiener_img3};
    labels = {'Q1-Original Image', 'Q1-Averaging Filtering with 3x3 Kernel', 'Q1-Averaging Filtering with 9x9 Kernel', 'Q1-Median Filtering with 3x3', "Q1-Wiener Filtering with 3x3, Estimate " + noise_out, "Q1-Wiener Filtering with 3x3, Estimate " + noise_out * 5,"Q1-Wiener Filtering with 9x9, Estimate " };
    figure;
    for i=1:length(images)
        currentImage = images{i};
        % Create a subplot
        subplot(3, 3, i);
        % Display the image with its label
        imshow(currentImage, []);
        title(labels{i} + " " + img_name);
        imwrite(mat2gray(currentImage),fullfile("Q1_Resulting_Images", labels{i}+".jpg"));
    end
    % Adjust layout
    sgtitle("Q1-" + img_name + " Images with Labels");
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile("Q1_Resulting_Images", img_name + " Images with Labels.jpg"));
end

%% This function will take kernel size and create averaging kernel
function averaging_kernel = createAveragingKernel(kernel_size)
    averaging_kernel = ones(kernel_size,kernel_size) * (1/(kernel_size^2));
end