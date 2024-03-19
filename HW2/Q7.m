clear; clc; close all;
%% Read Images
 mri_img = imread("MRI.png");
corrected_img = uint8(histogram_equalization(mri_img, 256));
c2 = histeq(mri_img,256);

images = {mri_img,corrected_img,c2};
labels = {"Normal MRI Image", "Histogram Equalization by Function Defined by Me", "Histogram Equalization by Default MATLAB function"};

showImages(images,labels,"Q7_Resulting_Images","Histogram Equalization",1,3)

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
function corrected_img = histogram_equalization(image, L)
    % Create histogram for image
     [m,n] = size(image);
    % Create normalized Image Histogram
    hist = zeros(1,256);
    for row=1:m
        for col=1:n
            hist(image(row,col)+1) = hist(image(row,col)+1)+1;
        end
    end
    normalized_hist = hist / (m*n)
    lookup_transformation_table = zeros(256); 
    for k=1:256
        lookup_transformation_table(k) = (L-1) * sum(normalized_hist(1:k));
    end
    corrected_img = zeros(m,n);
    for row=1:m
        for col=1:n
            corrected_img(row,col) = lookup_transformation_table(image(row,col)+1);
        end
    end
end