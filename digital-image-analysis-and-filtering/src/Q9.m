clear; clc; close all;
%% Read Images
high_boost_filter = (1/16)* [-1 -2 -1; -2 28 -2; -1 -2 -1];

%% Part a- Write a MATLAB script that displays the magnitude of the 2D 256×256 DFT of this
% filter, centering so the DC term is at the center of the image. Include the resulting plot in
% the writeup. Interpret what you see.
% Compute the 2D DFT of the filter
fft_filter = fftshift(fft2(high_boost_filter, 256, 256));
images_a ={fft_filter};
labels_a = {"FFT of High Boost Filter"}
showFFT(images_a,labels_a, "Q9_Resulting_Images/a", "FFT of Filter", 1,1)

%% Part b- Write a MATLAB script that applies the filter to the image tiger.png and displays the
% result. Include the resulting image in your writeup. Does this agree with your
% interpretation of the DFT?
% Read Image
img = imread("tiger.png");
% Get image size
[m,n] = size(img);
%Create HighBoost Filter According to that size
fft_filter_2 = fftshift(fft2(high_boost_filter, m, n));
% Compute the Fourier Transform of the image
F = fftshift(fft2(double(img)));
G = F .* fft_filter_2;
% Compute the inverse Fourier Transform to obtain the filtered image
filtered_img = real(ifft2(ifftshift(G)));

%Show Images in Fourier Domain
images_b ={F,fft_filter_2,G};
labels_b = {"FFT of Tiger Image (centered)","FFT of High Boost Filter (centered)", "Resulting Filtered Image in Fourier Domain"}
showFFT(images_b,labels_b, "Q9_Resulting_Images/b", "Filtered Image in frequency Domain", 1,3)

%Show Images in Spatial Domain
images_b_2 ={img,filtered_img,uint8(filtered_img)-img};
labels_b_2 = {"Original Image","Filtered Image","Difference"}
showImages(images_b_2,labels_b_2, "Q9_Resulting_Images/b", "Filtered Image in spatial Domain", 1,3)


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
        try
            disp("here")
            imwrite(mat2gray(currentImage),fullfile(file_name, labels{i}+".jpg"));
        catch
             imwrite(mat2gray(abs(currentImage)),fullfile(file_name, labels{i}+"-magnitude.png"));
             imwrite(mat2gray(angle(currentImage)),fullfile(file_name, labels{i}+"-phase.png"));
        end
    end
    % Adjust layout
    sgtitle(final_image_name);
    set(gcf, 'Position', [100, 100, 800, 600]);
    saveas(gcf, fullfile(file_name, final_image_name+ ".jpg"));
end

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