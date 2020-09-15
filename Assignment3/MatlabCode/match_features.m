function index1to2 = match_features(previous,next)
path1 = [int2str(previous),'.png'];
path2 = [int2str(next), '.png'];
rgbImage1 = imread(path1);
rgbImage2 = imread(path2);
grayscaleImage1 = single(rgb2gray(rgbImage1)); 
grayscaleImage2 = single(rgb2gray(rgbImage2)); 

[keypoints1,features1] = sift(grayscaleImage1,'Levels',4,'PeakThresh',5);
[keypoints2,features2] = sift(grayscaleImage2,'Levels',4,'PeakThresh',5);
index1to2 = matchFeatures(features1',features2','unique', true, 'MatchThreshold', 0.75);
matchedpoints1to2_1 = zeros(size(index1to2,1),2);
matchedpoints1to2_2 = zeros(size(index1to2,1),2);
for i = 1:size(index1to2,1)
    matchedpoints1to2_1(i,1) = keypoints1(1,index1to2(i,1));
    matchedpoints1to2_1(i,2) = keypoints1(2,index1to2(i,1));
    matchedpoints1to2_2(i,1) = keypoints2(1,index1to2(i,2));
    matchedpoints1to2_2(i,2) = keypoints2(2,index1to2(i,2));
end
figure; 
showMatchedFeatures(grayscaleImage1,grayscaleImage2,matchedpoints1to2_1,matchedpoints1to2_2,'montage');
titleString = ['Matched Features Between Image ', int2str(previous), ' and ', int2str(next)];

title(titleString);
