clear; clc; close all;
%Read gaussian noise image
edges_gnoise = imread("noisy.png");
%Convert the image to the grayscale
if size(edges_gnoise, 3) == 3
    edges_gnoise = rgb2gray(edges_gnoise);
end
% Create large gaussian kernel
h_noise = fspecial('gaussian', [21 21],3.5);
h_laplacian = fspecial('laplacian', 0);

%Filter image
filtered_img_noise_1 = conv2(edges_gnoise, h_noise);
filtered_img_laplacian_1 = conv2(filtered_img_noise_1, h_laplacian );

%Filter image
filtered_img_laplacian_2 = conv2(edges_gnoise, h_laplacian );
filtered_img_noise_2 = conv2(filtered_img_laplacian_2, h_noise );


images = {edges_gnoise,filtered_img_laplacian_1,filtered_img_noise_2,abs(filtered_img_laplacian_1-filtered_img_noise_2)};
labels = {"Original Image", "First Noise Then Laplacian", "First Laplacian Then Noise", "Difference"};

showImages(images, labels, "Q9_Resulting_Images", "Order of Filterings", 2,2)

if filtered_img_laplacian_1 == filtered_img_noise_2
    disp(" the result be the same if the order of these operations is reversed")
else
    disp(" the result be not the same if the order of these operations is reversed")
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
end

