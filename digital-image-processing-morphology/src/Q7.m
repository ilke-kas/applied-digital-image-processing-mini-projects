clear; clc; close all;
% Read the image
img = imread("Circle_and _Lines.png");
img = rgb2gray(img);
% In this section you will be separating out various objects from the images using the opening
% function. For the given image Circle_and_Lines.png, use the opening technique with the
% appropriate structuring element. Your mission is to separate the circles from the lines:
%% Part a-Determine the proper opening structuring element(s) to separate the image above into two
%separate images, one only showing circles, and one only showing lines. Print the final
%images and describe the structuring element(s) used. Ideally, you should only need one
%structuring element to isolate one of these, and then you can use a subtraction method.
types = ["diamond", "disk", "square", "cube", "sphere"];
images = {};
labels = {};
for j=1:length(types)
    r = 22;
    SE = strel(types(j),r);
    open_img = imopen(img,SE);
    images{2*j-1} = open_img;
    labels{2*j-1} = types(j);
    images{2*j} = img-open_img;
    labels{2*j} = types(j) + " Extracted Lines";
end
showImages(images,labels, "Q7_Resulting_Images/a", "open image",5,2)
%% Part b- What are the drawbacks or limitations of this method? Compare and contrast with the
% previous methods you have implemented in any of the prior problems.

%% Part c- Apply opening to the same image with the same structural element(s) of different sizes.
% How do the sizes of the structuring elements affect the results? (Show images with
% titles/labels).
types = {'diamond', 'disk', 'square', 'cube', 'sphere'};
sizes = [5, 10, 15, 20, 25];
for j = 1:length(types)
    images_c = {};
    labels_c = {};
    for k = 1:length(sizes)
        SE = strel(types{j}, sizes(k));
        open_img = imopen(img, SE);
        images_c{2*k-1} = open_img;
        labels_c{2*k-1} = strcat(types{j}, " Extracted Circles ", num2str(sizes(k)));
        images_c{2*k} = img - open_img;
        labels_c{2*k} = strcat(types{j}, " Extracted Lines ", num2str(sizes(k)));
    end
    showImages(images_c, labels_c, "Q7_Resulting_Images/c", strcat("open image ", types{j}), 5, 2);
end

%% Part d- Develop an algorithm: using the appropriate morphological filters, to count how many
% circles and how many lines are there in your outputted images from (a). Label each item
% in the picture with a distinct integer (suggestion: use MATLAB%s "text” command).
% Discuss your algorithm briefly. Report the algorithm for the code, counting results, and
% final images in the report. NOTE: there are several helpful built-in matlab commands for
% working with binary objects. if you use them, report what they are doing.
%%  For disks
SE = strel("disk", 22);
open_img = imopen(img, SE);
countAndLabel(open_img)

%% For lines
SE = strel("disk", 22);
open_img = imopen(img, SE);
SE2 = strel("disk", 4);
lines_img = img - open_img
lines_img = imopen(lines_img, SE2);
countAndLabel(lines_img)

function countAndLabel(open_img)
    se = strel('disk', 3); % Define the structuring element (disk shape with radius 3)
    image_dilated = imdilate(open_img, se); % Dilate the image
    image_eroded = imerode(open_img, se); % Erode the image
    
    % Get the contours by subtracting the eroded image from the dilated image
    contours = image_dilated - image_eroded;
    figure 
    imshow(contours, [])

    
    % Find connected components in the binary image
    cc = bwconncomp(contours);
    
    % Calculate properties of the connected components
    props = regionprops(cc, 'Centroid');
    
    % Plot the contours and mark the centroids with numbers
 
    hold on;
    for i = 1:length(props)
        centroid = props(i).Centroid;
        text(centroid(1), centroid(2), num2str(i), 'Color', 'red', 'FontSize', 12);
    end
    hold off;
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


