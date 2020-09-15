function featurevector = CalculateFeatureVector(Image)

Gaussian = cell(1,7);
GaussianPyramid = cell(1,7);
LaplacianPyramid = cell(1,6);
for i = 1:7
    Gaussian{1,i} = fspecial('Gaussian', 3*2^(i-1)+1, 2^(i-1));
end
for j = 1:7
    GaussianPyramid{1,j} = imresize(conv2(Image, Gaussian{1,j}, 'same'), 0.5^(j-1));
end
for j = 1:6
    LaplacianPyramid{1,j} = GaussianPyramid{1,j} - imresize(GaussianPyramid{1,j+1},2);
end

KeypointMatrix = [0,0,0];
threshold = 1;
neighborarray = zeros(1,3*3*3-1);

for i = 2:5
    low = imresize(LaplacianPyramid{1,i-1},0.5);
    middle = LaplacianPyramid{1,i};
    high = imresize(LaplacianPyramid{1,i+1},2);
    [row,col] = size(low);
    for j = 2:row-1
        for k = 2:col-1
           neighborarray(1,1) = low(j-1,k-1); neighborarray(1,2) = low(j-1,k); neighborarray(1,3) = low(j-1,k+1);
           neighborarray(1,4) = low(j,k-1); neighborarray(1,5) = low(j,k); neighborarray(1,6) = low(j,k+1);
           neighborarray(1,7) = low(j+1,k-1); neighborarray(1,8) = low(j+1,k); neighborarray(1,9) = low(j+1,k+1);
           
           neighborarray(1,10) = high(j-1,k-1); neighborarray(1,11) = high(j-1,k); neighborarray(1,12) = high(j-1,k+1);
           neighborarray(1,13) = high(j,k-1); neighborarray(1,14) = high(j,k); neighborarray(1,15) = high(j,k+1);
           neighborarray(1,16) = high(j+1,k-1); neighborarray(1,17) = high(j+1,k); neighborarray(1,18) = high(j+1,k+1);
           
           neighborarray(1,19) = middle(j-1,k-1); neighborarray(1,20) = middle(j-1,k); neighborarray(1,21) = middle(j-1,k+1);
           neighborarray(1,22) = middle(j,k-1); neighborarray(1,23) = middle(j,k+1);
           neighborarray(1,24) = middle(j+1,k-1); neighborarray(1,25) = middle(j+1,k); neighborarray(1,26) = middle(j+1,k+1);

           if((middle(j,k)-max(neighborarray)>threshold) || (-middle(j,k)+min(neighborarray)>threshold))
               if (KeypointMatrix ~= [0,0,0])
                   KeypointMatrix = [KeypointMatrix;j,k,i-1];
               else 
                   KeypointMatrix = [j,k,i-1];
               end
           end
        end
    end
end
KeypointMatrixNormal = zeros(size(KeypointMatrix,1),3);
for i = 1:size(KeypointMatrix,1)
    if KeypointMatrix(i,3) == 1
        KeypointMatrixNormal(i,1) = KeypointMatrix(i,1)*2;
        KeypointMatrixNormal(i,2) = KeypointMatrix(i,2)*2;
        KeypointMatrixNormal(i,3) = 1;
    elseif KeypointMatrix(i,3) == 2
        KeypointMatrixNormal(i,1) = KeypointMatrix(i,1)*4;
        KeypointMatrixNormal(i,2) = KeypointMatrix(i,2)*4;
        KeypointMatrixNormal(i,3) = 2;
    elseif KeypointMatrix(i,3) == 3
        KeypointMatrixNormal(i,1) = KeypointMatrix(i,1)*8;
        KeypointMatrixNormal(i,2) = KeypointMatrix(i,2)*8;
        KeypointMatrixNormal(i,3) = 3;
    elseif KeypointMatrix(i,3) == 4
        KeypointMatrixNormal(i,1) = KeypointMatrix(i,1)*16;
        KeypointMatrixNormal(i,2) = KeypointMatrix(i,2)*16;
        KeypointMatrixNormal(i,3) = 4;
    end
end


window_size = 17;
KeypointMatrixAwayFromBound = [];
for i = 1:size(KeypointMatrix,1)
    level = KeypointMatrix(i,3);
    if KeypointMatrix(i,1)>window_size/2 && KeypointMatrix(i,2)>window_size/2  && size(Image,2)*0.5^level-KeypointMatrix(i,2)>window_size/2 && size(Image,1)*0.5^level-KeypointMatrix(i,1)>window_size/2
        KeypointMatrixAwayFromBound = [KeypointMatrixAwayFromBound;KeypointMatrix(i,:)];
    end
end

gradientDx = cell(1,7);
gradientDy = cell(1,7);
for i = 1:7
    [gradientDx{1,i}, gradientDy{1,i}] = gradient(GaussianPyramid{1,i});
end

gradientFeatureDx = zeros(window_size,window_size,size(KeypointMatrixAwayFromBound,1));
gradientFeatureDy = zeros(window_size,window_size,size(KeypointMatrixAwayFromBound,1));
gradientMagnitude = zeros(window_size,window_size,size(KeypointMatrixAwayFromBound,1));
GaussianWeighted = fspecial('Gaussian', 17, 4);
gradientMagnitudeGuassianWeighted = zeros(window_size,window_size,size(KeypointMatrixAwayFromBound,1));
gradientOrientation = zeros(window_size,window_size,size(KeypointMatrixAwayFromBound,1));
for i = 1:size(KeypointMatrixAwayFromBound,1)
    level = KeypointMatrixAwayFromBound(i,3);
    gredientDxatthislevel = gradientDx{1,level+1};
    gredientDyatthislevel = gradientDy{1,level+1};
    for j = 1:window_size
        for k = 1:window_size
            gradientFeatureDx(j,k,i) = gredientDxatthislevel(KeypointMatrixAwayFromBound(i,1)+j-(window_size+1)/2,KeypointMatrixAwayFromBound(i,2)+k-(window_size+1)/2);
            gradientFeatureDy(j,k,i) = gredientDyatthislevel(KeypointMatrixAwayFromBound(i,1)+j-(window_size+1)/2,KeypointMatrixAwayFromBound(i,2)+k-(window_size+1)/2);
            gradientMagnitude(j,k,i) = sqrt(gradientFeatureDx(j,k,i)^2+gradientFeatureDy(j,k,i)^2);
            gradientMagnitudeGuassianWeighted(j,k,i) = gradientMagnitude(j,k,i)*GaussianWeighted(j,k);
            gradientOrientation(j,k,i) = rad2deg(atan2(gradientFeatureDy(j,k,i),gradientFeatureDx(j,k,i))+pi);
        end
    end
end

orientationhistogram = zeros(size(KeypointMatrixAwayFromBound,1),36);
for i = 1:size(KeypointMatrixAwayFromBound,1)
    for j = 1:window_size
        for k = 1:window_size
            angleinwhichbin = ceil(gradientOrientation(j,k,i)/10);
            orientationhistogram(i,angleinwhichbin) = orientationhistogram(i,angleinwhichbin) + gradientMagnitudeGuassianWeighted(j,k,i);
        end
    end
end


SIFTfeaturevector = zeros(size(KeypointMatrixAwayFromBound,1),39);
for i = 1:size(KeypointMatrixAwayFromBound,1)
    SIFTfeaturevector(i,1) = KeypointMatrixAwayFromBound(i,1);
    SIFTfeaturevector(i,2) = KeypointMatrixAwayFromBound(i,2);
    SIFTfeaturevector(i,3) = 2^KeypointMatrixAwayFromBound(i,3);
end

for i = 1:size(KeypointMatrixAwayFromBound,1)
    [peaks, locationsofpeaks] = findpeaks(orientationhistogram(i,:));
    [largestweightedgradientmagnitude,largestbin] = max(peaks);
    largestbin = locationsofpeaks(largestbin);
    for j = 1:36
        if mod(largestbin+j-1,36) ~= 0
            SIFTfeaturevector(i,j+3) = orientationhistogram(i,mod(largestbin+j-1,36));
        else
            SIFTfeaturevector(i,j+3) = orientationhistogram(i,36);
        end
    end
end

featurevector = SIFTfeaturevector;

end