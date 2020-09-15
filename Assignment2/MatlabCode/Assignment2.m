rgbImage = imread('Manor.png');
grayscaleImage = rgb2gray(rgbImage); 

location = [600 400];
a = RotateScale(grayscaleImage, location(1), location(2), 60, 1.5);
region_size = 128;
region_interest = grayscaleImage(location(1)-region_size/2+1:location(1)+region_size/2, location(2)-region_size/2+1:location(2)+region_size/2);
region_interest_in_transformed_Image = a(size(a,1)/2-region_size/2+1:size(a,1)/2+region_size/2, size(a,2)/2-region_size/2+1:size(a,2)/2+region_size/2);
featureMatrix1 = CalculateFeatureVector(region_interest);
featureMatrix2 = CalculateFeatureVector(region_interest_in_transformed_Image);
for i = 1:size(featureMatrix1,1)
    featureMatrix1(i,1) = featureMatrix1(i,1)*featureMatrix1(i,3);
    featureMatrix1(i,2) = featureMatrix1(i,2)*featureMatrix1(i,3);
end

for i = 1:size(featureMatrix2,1)
    featureMatrix2(i,1) = featureMatrix2(i,1)*featureMatrix2(i,3);
    featureMatrix2(i,2) = featureMatrix2(i,2)*featureMatrix2(i,3);
end

matchVector = zeros(1, size(featureMatrix1,1));
threshold = 0.25;
coefficientVector = zeros(size(featureMatrix1,1), size(featureMatrix2,1));
for i = 1:size(featureMatrix1,1)
    for j = 1:size(featureMatrix2,1)
        coefficientVector(i, j) = calculateBhattacharya_coefficient(featureMatrix1(i,4:39),featureMatrix2(j,4:39));
    end

end
for i = 1:size(featureMatrix1,1)
    for j = 1:size(featureMatrix2,1)
    minValue = coefficientVector(i, j);
    if minValue<threshold && minValue == min(coefficientVector(i,:)) && minValue == min(coefficientVector(:,j))
        matchVector(1, i) = j;
    end
    end
end
sumMatrix = [region_interest region_interest_in_transformed_Image];
figure(1);
imshow(sumMatrix, []);
color = ['b','g','y','m'];
for i = 1:size(matchVector,2)
    if matchVector(1,i) ~= 0
        viscircles([featureMatrix1(i,2) featureMatrix1(i,1)],featureMatrix1(i,3)/4,'color',color(log2(featureMatrix1(i,3))));
    end
end

for i = 1:size(matchVector,2)
    if matchVector(1,i) ~= 0
        viscircles([featureMatrix2(matchVector(1,i),2)+size(region_interest,2) featureMatrix2(matchVector(1,i),1)],featureMatrix2(matchVector(1,i),3)/4,'color',color(log2(featureMatrix2(matchVector(1,i),3))));
    end
end
figure(1);
hold on
for i = 1:size(matchVector,2)
    if matchVector(1,i) ~= 0
    plot([featureMatrix1(i,2) featureMatrix2(matchVector(1,i),2)+size(region_interest,2)],[featureMatrix1(i,1) featureMatrix2(matchVector(1,i),1)], 'LineWidth', 1);
    end
end
hold off
title('Center=(500,550) Roatation=60 ScaleFactor=1.05')

%for i = 1:size(featureMatrix1,1)
 %   viscircles([featureMatrix1(i,2) featureMatrix1(i,1)],featureMatrix1(i,3),'color',color(log2(featureMatrix1(i,3))));
%end

%viscircles([512 512], 20 ,'color','r');
%axis([1 1024 1 1024]);
%title('Location=(400,600) Roatation=30 ScaleFactor=1.05')
