clear; clc; close all;
%% Read Images
% Read gaussian noise image
edges_gnoise = imread("Edges_gnoise.tif");
edges_gnoise = rgb2gray(edges_gnoise);
%% Part a- Suppose we filter an image twice: we first apply a 3×3 averaging box filter, and then filter the
% resulting image with the 3×3 Laplacian filter (the one with -4 in the
% middle element).  Determine (mathematically) a single 2D filter that will result in the same output using a
% single pass. Show your work.

% Multiple Pass in spatial domain directly
%Create Averaging Kernel
averaging_kernel_3 = createAveragingKernel(3);
    
%Apply averaging kernels
averaging_img_3 = imfilter(edges_gnoise, averaging_kernel_3);
laplacian_filter = [0 1 0
                    1 -4 1
                    0 1 0];
final_image_multipass = imfilter(averaging_img_3,laplacian_filter);

% One Pass trial by using Fourier Transformations
average_fft = fft2(averaging_kernel_3)
laplacian_fft = fft2(laplacian_filter)
one_pass_filter_fft = average_fft .* laplacian_fft
one_pass_filter_ifft = ifft(one_pass_filter_fft)


%Apply to image in spatial domain
final_image_onepass = imfilter(edges_gnoise,one_pass_filter_ifft);

images_a = {edges_gnoise,final_image_multipass,final_image_onepass};
labels_a = {"Original Image", "Multipass in spatial domain","One Pass in Frequency Domain"};
showImages(images_a,labels_a,"Q5_Resulting_Images/a","One Pass Filter Finding",1,3)

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
