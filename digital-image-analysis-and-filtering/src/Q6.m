clear; clc; close all;
%%  Using MATLAB, MS Paint, or any other generative method of your choice, sketch 4 different
% images that all have the histogram given by: p(I(x,y) = 0) = 0.25,
% p(I(x,y) = 128) = 0.25, p(I(x,y) = 255) = 0.5
images_a = {};
labels_a = {};
% First Image
img_1 = [zeros(256,256) ones(256,256)*128; ones(256,512)*255];

% Second Image
% Randomize the image indices 
% Get the dimensions of the image
[rows, cols] = size(img_1);

% Reshape the image into a column vector
image_vector = reshape(img_1, [], 1);

% Generate random indices
random_indices = randperm(rows * cols);

% Rearrange the elements according to the random indices
randomized_image_vector = image_vector(random_indices);

% Reshape the randomized vector back into an image
img_2 = reshape(randomized_image_vector, [rows, cols]);

% Third Image
img_3 = uint8(repmat([ones(4,4)*255 zeros(4,4) ; ones(4, 4)*128 ones(4,4)*255],64));

%Fourth Image
img_4 = uint8(repmat([ones(32,32)*255 zeros(32,32) ; ones(32, 32)*128 ones(32,32)*255],8));

images_a ={img_1,img_2,img_3,img_4};
labels_a = {"Image 1", "Image 2", "Image 3","Image 4"};
showImages(images_a,labels_a,"Q6_Resulting_Images/a","Same Histogram Different Images",2,2)

%% Now, suppose each of these images was blurred using a 9×9 box averaging filter. Will the images
% have the same histogram after this operation? Why or why not?
averaging_kernel_9 = createAveragingKernel(9);
images_b={};
labels_b={};
for i =1:length(images_a)
    averaging_img = imfilter(images_a{i}, averaging_kernel_9);
    images_b{length(images_b)+1} = images_a{i};
    images_b{length(images_b)+1} = averaging_img;
    labels_b{length(labels_b)+1} = "Original Image "+ i;
    labels_b{length(labels_b)+1} = "Averaged Image "+ i;
end
showImages(images_b,labels_b,"Q6_Resulting_Images/b","After Averaging",4,2)

%% This function will take kernel size and create averaging kernel
function averaging_kernel = createAveragingKernel(kernel_size)
    averaging_kernel = ones(kernel_size,kernel_size) * (1/(kernel_size^2));
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
        title(labels{i});
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