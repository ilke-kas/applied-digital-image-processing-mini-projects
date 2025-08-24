clear; clc; close all;
%% Read Tiger Image
tiger_img = imread("zero_pad.png");
tiger_img = rgb2gray(tiger_img);
% Compute the Fourier Transform of the image
F = fftshift(fft2(double(tiger_img)));
padded_img  =  padarray(tiger_img,[10 10],0,'both')
padded_F = fftshift(fft2(double(padded_img)));
images_a ={F,padded_F};
labels_a = {"Original Image", "Padded Image"}
showFFT(images_a,labels_a, "Q12_Resulting_Images", "FFT of Filter", 1,2)
%% This function will display the images 
function showFFT(images, labels, file_name, final_image_name, subplot_x,subplot_y)
%Display the Images 
    figure
    for i=1:length(images)
        currentImage = images{i};
        % Create a subplot
        subplot(subplot_x, subplot_y, i);
        % Display the image with its label
        imshow(log(1+abs(currentImage)), []);
        % Compute the noise standard deviation and mean before and after filtering. 
        title(labels{i});
        try
            imwrite(mat2gray(log(1+abs(currentImage))),fullfile(file_name, labels{i}+".jpg"));
        catch
             imwrite(mat2gray(log(1+abs(currentImage))),fullfile(file_name, labels{i}+"-magnitude.png"));
             imwrite(mat2gray(angle(currentImage)),fullfile(file_name, labels{i}+"-phase.png"));
        end
    end
    % Adjust layout
    sgtitle(final_image_name);
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end