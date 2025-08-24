clear; clc; close all;
%% Read Images
 boat_img = imread("boat.png");

 %% a- First, filter the image using the low-pass filter ones(5)/25. How does the image
 % compare with the original? How and where is the noise visibly reduced?
low_pass_filt = ones(5) * (1/25);
filtered_img = imfilter(boat_img, low_pass_filt);
images_a = {boat_img,filtered_img,boat_img-filtered_img};
labels_a = {"Original Image","Filtered Image with Low Pass Filter","Difference Image"};
showImages(images_a, labels_a, "Q1_Resulting_Images/a", "Low Pass Filtered",1,3)
flicker_animation_show(images_a, labels_a)
flicker_animation_save(images_a, labels_a, "Q1_Resulting_Images/a", "Low Pass Filtered Image Flickered Animation")

 %% b- Next, filter the image using a 5x5 median filter. How does the image compare
%with the original? How does it compare with the image in part (a)? Which image seems
%perceptually better? Pay particular attention to high-contrast edges, flat areas, and areas
%of fine detail. A good way to compare and contrast the two images is with a flicker
%animation using commands like while 1, figure(1), pause(.5), figure(2), pause(.5), end.
median_filtered_img = medfilt2(boat_img, [5, 5]);
%Evaluation Metrics
psnr_box = psnr(filtered_img,boat_img);
psnr_median = psnr(median_filtered_img,boat_img);
disp("PSNR BOX "+psnr_box)
disp("PSNR MEDIAN "+psnr_median)
disp(" ")

mse_box = mse(filtered_img,boat_img);
mse_median = mse(median_filtered_img,boat_img);
disp("MSE BOX "+mse_box)
disp("MSE MEDIAN "+mse_median)
disp(" ")

ssim_box = ssim(filtered_img,boat_img);
ssim_median = ssim(median_filtered_img,boat_img);
disp("SSIM BOX "+ssim_box)
disp("SSIM MEDIAN "+ssim_median)
disp(" ")


images_b = {boat_img,median_filtered_img,boat_img-median_filtered_img, filtered_img};
labels_b = {"Original Image","Filtered Image with Median Filter","Difference Image", "Filtered Image"};
showImages(images_b, labels_b, "Q1_Resulting_Images/b", "Median Filtered",2,2)
flicker_animation_show(images_b, labels_b)
flicker_animation_save(images_b, labels_b, "Q1_Resulting_Images/b", "Median Filtered Image Flickered Animation")

% This function shows the flicker animation in MATLAB
function flicker_animation_show(images, labels)
    % Flicker animation
    count = 1;
    figure;
    while count < 20
        imshow(images{1},[]);
        title(labels{1})
        pause(.5)
        imshow(images{2},[]);
        title(labels{2})
        pause(.5)
        count= count+1;
    end
end

% This function saved the flicker animation video 
function flicker_animation_save(images, labels, file_name, final_image_name)
    % Flicker animation
    v = VideoWriter(file_name+"/"+final_image_name+".avi");
    v.FrameRate = 1;
    open(v)
    count = 1;
    while count < 40
        writeToVideo(images{1},v,labels{1});
        writeToVideo(images{2},v,labels{2});
        count= count+1;
    end
    close(v);
end

% This function writes given image and label to the video
function writeToVideo(image, video, label)
    % Create a figure without displaying it
    fig = figure('Visible', 'off');
    subplot(1, 1, 1);
    % Display the image with its label
    imshow(image, []);
    % Compute the noise standard deviation and mean before and after filtering. 
    title(label);
    writeVideo(video, getframe(fig));
    % for i = 1:10 % Repeat the first frame 10 times to slow down the frame rate
    %     writeVideo(video, getframe(fig));
    % end
    close(fig);
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
