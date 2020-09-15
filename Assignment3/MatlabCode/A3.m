rgbImage = imread('1.png');
grayscaleImage = rgb2gray(rgbImage); 
rgbImage0 = imread('0.png');
grayscaleImage0 = single(rgb2gray(rgbImage0)); 
rgbImage1 = imread('1.png');
grayscaleImage1 = single(rgb2gray(rgbImage1)); 
rgbImage2 = imread('2.png');
grayscaleImage2 = single(rgb2gray(rgbImage2)); 
rgbImage3 = imread('3.png');
grayscaleImage3 = single(rgb2gray(rgbImage3)); 
rgbImage4 = imread('4.png');
grayscaleImage4 = single(rgb2gray(rgbImage4)); 
rgbImage5 = imread('5.png');
grayscaleImage5 = single(rgb2gray(rgbImage5)); 
Image1024 = zeros(1024,1024);
for i = 1:1024
    for j = 1:1024
        Image1024(i,j) = 256;
    end
end
for i = 1:size(grayscaleImage,1)
    for j = 1:size(grayscaleImage,2)
        Image1024(i+512-size(grayscaleImage,1)/2,j+512-size(grayscaleImage,2)/2) = grayscaleImage(i,j);
    end
end
region_interest_size = 128;
region_interest = Image1024(500-region_interest_size/2+1:500+region_interest_size/2, 500-region_interest_size/2+1:500+region_interest_size/2);
single_region_interest = single(region_interest);
imshow(single_region_interest,[]);

featureVectorA2 = CalculateFeatureVector(region_interest);
for i = 1:size(featureVectorA2,1)
    featureVectorA2(i,1) = featureVectorA2(i,1)*featureVectorA2(i,3);
    featureVectorA2(i,2) = featureVectorA2(i,2)*featureVectorA2(i,3);
end

[keypoints,features] = sift(single_region_interest,'Levels',4,'PeakThresh',5);
figure(1);
subplot(2,2,1);

imshow(region_interest,[]);hold on;
title('SIFT keypoints from my solution');



for i = 1:size(featureVectorA2,1)
    viscircles([featureVectorA2(i,2) featureVectorA2(i,1)],featureVectorA2(i,3));
end


subplot(2,2,2);

imshow(single_region_interest,[]);hold on;
viscircles(keypoints(1:2,:)',keypoints(3,:)');
title('SIFT keypoints from provided implementation');

theta = 45;
single_region_interest_rotate = imrotate(single_region_interest,theta,'crop');
[keypoints_rotate,features_rotate] = sift(single_region_interest_rotate,'Levels',4,'PeakThresh',5);
featureVectorA2_rotate = CalculateFeatureVector(single_region_interest_rotate);
for i = 1:size(featureVectorA2_rotate,1)
    featureVectorA2_rotate(i,1) = featureVectorA2_rotate(i,1)*featureVectorA2_rotate(i,3);
    featureVectorA2_rotate(i,2) = featureVectorA2_rotate(i,2)*featureVectorA2_rotate(i,3);
end

subplot(2,2,3);
imshow(single_region_interest_rotate,[]);hold on;
for i = 1:size(featureVectorA2_rotate,1)
    viscircles([featureVectorA2_rotate(i,2) featureVectorA2_rotate(i,1)],featureVectorA2_rotate(i,3));
end

subplot(2,2,4);
imshow(single_region_interest_rotate,[]);hold on;
viscircles(keypoints_rotate(1:2,:)',keypoints_rotate(3,:)');

figure(2);
x1 = 1:36;
y11 = featureVectorA2(3,4:39);
y11 = y11/sum(y11(1,:));
y12 = featureVectorA2_rotate(6,4:39);
y12 = y12/sum(y12(1,:));
subplot(2,2,1);
plot(x1,y11,'LineWidth', 3);
title('Histograms of a chosen keypoint (my solution)');
x2 = 1:128;
y21 = features(:,5);
y22 = features_rotate(:,1);
subplot(2,2,2);
plot(x2,y21,'LineWidth', 3);
title('Histograms of a chosen keypoint (provided implementation)');
subplot(2,2,3);
plot(x1,y12,'LineWidth', 3);


subplot(2,2,4);
plot(x2,y22,'LineWidth', 3);

close all
x45 = RANSAC_match_features(grayscaleImage4,grayscaleImage5);


