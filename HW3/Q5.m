clear; clc; close all;
% There are many uses of morphological operations. For example, it can be used to fill in small
% spurious holes (%pepper noise ) in images. In this problem, read the ‘cameraman.png’ image. This
% image contains pepper noise.
%% Read Images
 drink_img = imread("Cameraman.png");

 %% Part a- Use a suitable structuring element to dilate this image, hence removing the ‘pepper’ noise
% from the image. Show your final image.
 SE = strel('disk',3);
 dilated_img = imdilate(drink_img,SE);
 figure;
 imshow(dilated_img, []);
 title("Dilated Image");

%% Part b- There is also “salt” noise in the image. The best way to filter noise in a gray scale image
% with morphological operations is to use open and close operations. Design an open-close
% gray scale morphology operation to reduce both salt and pepper noise. Show your final
% image.
opened_img = imopen(drink_img,SE);
closed_after_opened = imopen(opened_img,SE);
figure;
imshow(closed_after_opened, []);
title("Open-Closed Operations");

%% Part c- Compare the images from (a) and (b).
images = {drink_img, dilated_img,closed_after_opened};
labels = {"Original Image","Dilated Image","Close after Opened Image"};
showImages(images, labels, "Q5_Resulting_Images", "Noise Reduction-Morphology", 1,3);

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