clear; clc; close all;
%% Read Images
 drink_img = imread("drink.png");

 %% Part a- Use strel to create a structuring element d3, a disk of radius 3
 d3 = strel('disk',3);

 %% Part b- Apply d3 to erode the binary image in drink.png using imerode. Describe what happened
 % and why.
 eroded_img = imerode(drink_img,d3);
 images_b = {drink_img, eroded_img};
 labels_b = {"Original Image","Eroded Image"};
 showImages(images_b, labels_b, "Q4_Resulting_Images/b", "Eroded Image", 1,2)

 %% Part c- Apply d3 to dilate the result of part (b) using imdilate. Describe what happened and why.
% Note that the result is what you would have gotten by applying imopen to the original
% image with structuring element d3
dilated_after_eroded = imdilate(eroded_img,d3);
opened_img = imopen(drink_img,d3);
images_c = {drink_img, eroded_img, dilated_after_eroded, opened_img, opened_img-dilated_after_eroded};
labels_c = {"Original Image","Eroded Image", "Dilation of Erode Image","Open Image","Difference of Dilate+Erode and Open Image"};
showImages(images_c, labels_c, "Q4_Resulting_Images/c", "Open Image", 2,3)

%% Part d- Now suppose we were to reverse the order of erosion and dilation (i.e., morphological
% closing instead of morphological opening). Explain what you see, and discuss why the
% two results are different.
dilated_img = imdilate(drink_img,d3);
eroded_after_dilated = imerode(dilated_img,d3);
closed_img = imclose(drink_img,d3);
images_d = {drink_img, dilated_img, eroded_after_dilated, closed_img, closed_img-eroded_after_dilated};
labels_d = {"Original Image","Dilated Image", "Erode Dilated Image","Close Image","Difference of Erode+Dilate and Close Image"};
showImages(images_d, labels_d, "Q4_Resulting_Images/d", "Close Image", 2,3)

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