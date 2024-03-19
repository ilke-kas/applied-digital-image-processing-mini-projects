clear; clc; close all;

%% Part e- Create the following 500 × 500 8-bit images in MATLAB: A grayscale image with a Gaussian intensity distribution centered at (64, 64), described by the function given
[X,Y] = meshgrid(1:500,1:500);
image_e = uint8(255 * exp(-1* ((X-64).^2 + (Y-64).^2)/ 200^2));

quantize_values = {256,128,64,32,16}

%% Quantized Version of image with 128 gray levels
showQuantizedImages(image_e,quantize_values,"Q2_Resulting_Images","Quantized Image",3,2)


%% This function will display the images and their histograms
function showQuantizedImages(image, quantized_values, file_name, final_image_name, subplot_x,subplot_y)
%Display the Images 
    figure
    for i=1:length(quantized_values)
        % Perform Quantization 
        levels = linspace(0,255,quantized_values{i});
        currentImage = imquantize(image,levels);
        % Create a subplot
        subplot(subplot_x, subplot_y, i);
        % Display the image with its label
        imshow(currentImage, []);
        % Compute the noise standard deviation and mean before and after filtering. 
        title(final_image_name + quantized_values{i});
        imwrite(mat2gray(currentImage),fullfile(file_name, quantized_values{i}+".jpg"));
    end
    % Adjust layout
    sgtitle(final_image_name);
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end
