clear; clc; close all;
%% Read Images
fuzzy_cat = imread("fuzzycat.png");
%% Part a- Write a MATLAB program that performs a 5×5 averaging box filter on the image and
% displays the result. Include the result in the writeup. How does the image compare with
% the original? What details are different?
%Create Averaging Kernel
averaging_kernel_5 = createAveragingKernel(5);
    
%Apply averaging kernels
averaging_img_5 = imfilter(fuzzy_cat, averaging_kernel_5);
images_a = {fuzzy_cat,averaging_img_5};
labels_a = {"Original Image","Averaging Filter"};
showImages(images_a,labels_a,"Q4_Resulting_Images/a","Averaging Box Filtering 5x5",1,2)

%% Part b- Write a MATLAB program that implements equations 3-55 and 3-56 in G&W, with
% integer values of k ranging from 1 to 5 (inclusive) to apply unsharp masking, and displays
% all 6 images. Include all 6 images in the writeup. Explain what you see as k increases.
% How does the filtered image improve? Discuss specific regions in the image for full
% credit. Note that you should clip the results to [0, 255] before display.

%Equation 3-55- 𝑔mask(𝑥, 𝑦) = 𝑓(𝑥, 𝑦) − 𝑓'(𝑥, 𝑦) where 𝑓̅(𝑥, 𝑦) is the blurred image
gmask = fuzzy_cat - averaging_img_5;
%Equation 3-56- 𝑔(𝑥, 𝑦) = 𝑓(𝑥, 𝑦) + 𝑘𝑔mask(𝑥, 𝑦)
images_b ={};
labels_b={};
images_b{length(images_b)+1} = fuzzy_cat;
labels_b{length(labels_b)+1} = "Original Image";
for i=1:5
    gmask = fuzzy_cat - averaging_img_5;
    g = fuzzy_cat + i * gmask;
    images_b{length(images_b)+1} = min(max(g, 0), 255);;
    labels_b{length(labels_b)+1} = "Unsharp Masking with k="+i;
end
showImages(images_b,labels_b,"Q4_Resulting_Images/b","Unsharp Masking",2,3)


%% This function will take kernel size and create averaging kernel
function averaging_kernel = createAveragingKernel(kernel_size)
    averaging_kernel = ones(kernel_size,kernel_size) * (1/(kernel_size^2));
end

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
