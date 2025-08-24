clear; clc; close all;
%% Read Images
tumor_img = imread("tumor_img.png");
tumor_img = rgb2gray(tumor_img);
corrected_img = uint8(histogram_equalization(tumor_img, 256));

images = {tumor_img,corrected_img};
labels = {"Normal Tumor Image", "Histogram Equalization by Function Defined by Me"};

showImages(images,labels,"Q8_Resulting_Images","Histogram Equalization",1,2)

%% Low Color depth 
[X,Y] = meshgrid(1:500,1:500);
image_e = uint8(255 * exp(-1* ((X-64).^2 + (Y-64).^2)/ 200^2));

levels = linspace(0,255,16);
currentImage = imquantize(image_e,levels);
corrected_img_depth = uint8(histogram_equalization(currentImage, 16));
images = {currentImage,corrected_img_depth};
labels = {"Low Color Depth Image", "Histogram Equalization by Function Defined by Me"};

showImages(images,labels,"Q8_Resulting_Images","Histogram Equalization -Low Depth",1,2)


%% Noisy Images
edges_gnoise = imread("Edges_gnoise.tif");
edges_gnoise = rgb2gray(edges_gnoise);
corrected_img_noise = uint8(histogram_equalization(edges_gnoise, 256));

images = {edges_gnoise,corrected_img_noise};
labels = {"Noisy Image", "Histogram Equalization by Function Defined by Me"};

showImages(images,labels,"Q8_Resulting_Images","Histogram Equalization -Noisy",1,2)



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
    normalized_hist = hist ./ (m*n);
    lookup_transformation_table = zeros(1,256); 
    for k=1:256
        lookup_transformation_table(k) = round((L-1) * sum(normalized_hist(1:k)));
    end
    disp(lookup_transformation_table)
    corrected_img = zeros(m,n);
    for row=1:m
        for col=1:n
            corrected_img(row,col) = uint8(lookup_transformation_table(image(row,col)+1));
        end
    end
end