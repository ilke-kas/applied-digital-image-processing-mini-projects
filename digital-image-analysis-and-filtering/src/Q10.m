clear; clc; close all;
%% Read Tiger Image
tiger_img = imread("tiger.png");
% Compute the Fourier Transform of the image
F = fftshift(fft2(double(tiger_img)));

%% Part a - Create Gaussian Filter C_a = [100 0; 0 100] 
C_a = [100 0; 0 100] ;
filt = fftshift(guassflt(tiger_img, C_a));
G_a = F .* filt;
images_a ={F,filt,G_a};
labels_a = {"Original Image","FFT of Gaussian Filter","After Filtering In Frequency Domain"}
showFFT(images_a,labels_a, "Q10_Resulting_Images/a", "FFT of Filter", 1,3)
% Compute the inverse Fourier Transform to obtain the filtered image
filtered_img_a = real(ifft2(ifftshift(G_a)));
%Show Images in Spatial Domain
images_a_2 ={tiger_img,filtered_img_a,uint8(filtered_img_a)-tiger_img};
labels_a_2 = {"Original Image","Filtered Image","Difference"}
showImages(images_a_2,labels_a_2, "Q10_Resulting_Images/a", "Filtered Image in spatial Domain", 1,3)


%% Part b - Create Gaussian Filter C_b = [900 0; 0 900] 
C_b = [900 0; 0 900] ;
filt_b = fftshift(guassflt(tiger_img, C_b));
G_b = F .* filt_b;
images_b ={F,filt_b,G_b};
labels_b = {"Original Image","FFT of Gaussian Filter","After Filtering In Frequency Domain"}
showFFT(images_b,labels_b, "Q10_Resulting_Images/b", "FFT of Filter", 1,3)
% Compute the inverse Fourier Transform to obtain the filtered image
filtered_img_b = real(ifft2(ifftshift(G_b)));
%Show Images in Spatial Domain
images_b_2 ={tiger_img,filtered_img_b,uint8(filtered_img_b)-tiger_img};
labels_b_2 = {"Original Image","Filtered Image","Difference"}
showImages(images_b_2,labels_b_2, "Q10_Resulting_Images/b", "Filtered Image in spatial Domain", 1,3)

%% Part c - Create Gaussian Filter C_c = [900 0; 0 100] 
C_c = [900 0; 0 100] ;
filt_c = fftshift(guassflt(tiger_img, C_c));
G_c = F .* filt_c;
images_c ={F,filt_c,G_c};
labels_c = {"Original Image","FFT of Gaussian Filter","After Filtering In Frequency Domain"}
showFFT(images_c,labels_c, "Q10_Resulting_Images/c", "FFT of Filter", 1,3)
% Compute the inverse Fourier Transform to obtain the filtered image
filtered_img_c = real(ifft2(ifftshift(G_c)));
%Show Images in Spatial Domain
images_c_2 ={tiger_img,filtered_img_c,uint8(filtered_img_c)-tiger_img};
labels_c_2 = {"Original Image","Filtered Image","Difference"}
showImages(images_c_2,labels_c_2, "Q10_Resulting_Images/c", "Filtered Image in spatial Domain", 1,3)


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
% gaussfilt function takes as input a grayscale image 
% im and a 2x2 covariance matrix C.
% The filter returns a low-pass frequency-domain Gaussian filter 
% the same size as im centered at DC with the given covariance matrix.

function imfilt = guassflt(im, filt)
[a,b] = size(im);
[x,y] = meshgrid(1:b,1:a);
imfilt = exp(-0.5*sum([x(:)-(b+1)/2 y(:)-(a+1)/2].^2 *inv(filt),2));
imfilt = reshape(imfilt, [a b]);
maxi = max(imfilt(:));
imfilt = fftshift(imfilt/maxi);
end