rgbImage1 = imread('Paolina.jpg'); 
%rgbImage1 = imread('MyImage.jpg'); 

grayscaleImage1 = rgb2gray(rgbImage1);  
% Get the number of rows and columns for the input image matrix
[row,column] = size(grayscaleImage1);
LOG1 = make2DLOG(6,1);
LOG2 = make2DLOG(11,2);
LOG3 = make2DLOG(15,3);
LOG4 = make2DLOG(21,4);
LOG5 = make2DLOG(25,5);
LOG6 = make2DLOG(31,6);

% In order to show edges on the original image
rgbImage1_1 = rgbImage1;
rgbImage1_2 = rgbImage1;
rgbImage1_3 = rgbImage1;
rgbImage1_4 = rgbImage1;
rgbImage1_5 = rgbImage1;
rgbImage1_6 = rgbImage1;
%[GaborEven1,GaborOdd1] = make2DGabor(11,10,90);

Image1_LOG1 = conv2(grayscaleImage1, LOG1, 'same');
Image1_LOG2 = conv2(grayscaleImage1, LOG2, 'same');
Image1_LOG3 = conv2(grayscaleImage1, LOG3, 'same');
Image1_LOG4 = conv2(grayscaleImage1, LOG4, 'same');
Image1_LOG5 = conv2(grayscaleImage1, LOG5, 'same');
Image1_LOG6 = conv2(grayscaleImage1, LOG6, 'same');
%Image1_Gabor1 = conv2(grayscaleImage1, GaborOdd1, 'same');
%Image1_LOG1_Gray = mat2gray(Image1_LOG1);


% The edge matrix is used to store zero crossing points. If the point is on
% the edge, its value is set to 255 instead of 0 for other points.
edge_Image1_LOG1 = zeros(row,column);
edge_Image1_LOG2 = zeros(row,column);
edge_Image1_LOG3 = zeros(row,column);
edge_Image1_LOG4 = zeros(row,column);
edge_Image1_LOG5 = zeros(row,column);
edge_Image1_LOG6 = zeros(row,column);
%edge_Image1_Gabor1 = zeros(row,column);
%threshold = 0.1;(abs(Image1_LOG1(i+1,j-1)-Image1_LOG1(i-1,j+1))>threshold)

% A point is detected to be on the edge if the convoluted image matix has
% zero crossing on this point in any direction 
for i = 2:row-1
    for j = 2:column-1
        if (sign(Image1_LOG1(i-1,j))~=sign(Image1_LOG1(i+1,j))) 
            edge_Image1_LOG1(i,j) = 255;
            rgbImage1_1(i,j,1) = 255;
            rgbImage1_1(i,j,2) = 0;
            rgbImage1_1(i,j,3) = 0;
        elseif (sign(Image1_LOG1(i,j-1))~=sign(Image1_LOG1(i,j+1))) 
            edge_Image1_LOG1(i,j) = 255;
            rgbImage1_1(i,j,1) = 255;
            rgbImage1_1(i,j,2) = 0;
            rgbImage1_1(i,j,3) = 0;
        elseif (sign(Image1_LOG1(i-1,j-1))~=sign(Image1_LOG1(i+1,j+1))) 
            edge_Image1_LOG1(i,j) = 255;
            rgbImage1_1(i,j,1) = 255;
            rgbImage1_1(i,j,2) = 0;
            rgbImage1_1(i,j,3) = 0;
        elseif (sign(Image1_LOG1(i+1,j-1))~=sign(Image1_LOG1(i-1,j+1))) 
            edge_Image1_LOG1(i,j) = 255;
            rgbImage1_1(i,j,1) = 255;
            rgbImage1_1(i,j,2) = 0;
            rgbImage1_1(i,j,3) = 0;
        end 
        
        if (sign(Image1_LOG2(i-1,j))~=sign(Image1_LOG2(i+1,j))) 
            edge_Image1_LOG2(i,j) = 255;
            rgbImage1_2(i,j,1) = 255;
            rgbImage1_2(i,j,2) = 0;
            rgbImage1_2(i,j,3) = 0;
        elseif (sign(Image1_LOG2(i,j-1))~=sign(Image1_LOG2(i,j+1))) 
            edge_Image1_LOG2(i,j) = 255;
            rgbImage1_2(i,j,1) = 255;
            rgbImage1_2(i,j,2) = 0;
            rgbImage1_2(i,j,3) = 0;
        elseif (sign(Image1_LOG2(i-1,j-1))~=sign(Image1_LOG2(i+1,j+1))) 
            edge_Image1_LOG2(i,j) = 255;
            rgbImage1_2(i,j,1) = 255;
            rgbImage1_2(i,j,2) = 0;
            rgbImage1_2(i,j,3) = 0;
        elseif (sign(Image1_LOG2(i+1,j-1))~=sign(Image1_LOG2(i-1,j+1))) 
            edge_Image1_LOG2(i,j) = 255;
            rgbImage1_2(i,j,1) = 255;
            rgbImage1_2(i,j,2) = 0;
            rgbImage1_2(i,j,3) = 0;
        end 
        
        if (sign(Image1_LOG3(i-1,j))~=sign(Image1_LOG3(i+1,j))) 
            edge_Image1_LOG3(i,j) = 255;
            rgbImage1_3(i,j,1) = 255;
            rgbImage1_3(i,j,2) = 0;
            rgbImage1_3(i,j,3) = 0;
        elseif (sign(Image1_LOG3(i,j-1))~=sign(Image1_LOG3(i,j+1))) 
            edge_Image1_LOG3(i,j) = 255;
            rgbImage1_3(i,j,1) = 255;
            rgbImage1_3(i,j,2) = 0;
            rgbImage1_3(i,j,3) = 0;
        elseif (sign(Image1_LOG3(i-1,j-1))~=sign(Image1_LOG3(i+1,j+1))) 
            edge_Image1_LOG3(i,j) = 255;
            rgbImage1_3(i,j,1) = 255;
            rgbImage1_3(i,j,2) = 0;
            rgbImage1_3(i,j,3) = 0;
        elseif (sign(Image1_LOG3(i+1,j-1))~=sign(Image1_LOG3(i-1,j+1))) 
            edge_Image1_LOG3(i,j) = 255;
            rgbImage1_3(i,j,1) = 255;
            rgbImage1_3(i,j,2) = 0;
            rgbImage1_3(i,j,3) = 0;
        end 
        
        if (sign(Image1_LOG4(i-1,j))~=sign(Image1_LOG4(i+1,j))) 
            edge_Image1_LOG4(i,j) = 255;
            rgbImage1_4(i,j,1) = 255;
            rgbImage1_4(i,j,2) = 0;
            rgbImage1_4(i,j,3) = 0;
        elseif (sign(Image1_LOG4(i,j-1))~=sign(Image1_LOG4(i,j+1))) 
            edge_Image1_LOG4(i,j) = 255;
            rgbImage1_4(i,j,1) = 255;
            rgbImage1_4(i,j,2) = 0;
            rgbImage1_4(i,j,3) = 0;
        elseif (sign(Image1_LOG4(i-1,j-1))~=sign(Image1_LOG4(i+1,j+1))) 
            edge_Image1_LOG4(i,j) = 255;
            rgbImage1_4(i,j,1) = 255;
            rgbImage1_4(i,j,2) = 0;
            rgbImage1_4(i,j,3) = 0;
        elseif (sign(Image1_LOG4(i+1,j-1))~=sign(Image1_LOG4(i-1,j+1))) 
            edge_Image1_LOG4(i,j) = 255;
            rgbImage1_4(i,j,1) = 255;
            rgbImage1_4(i,j,2) = 0;
            rgbImage1_4(i,j,3) = 0;
        end
        
        if (sign(Image1_LOG5(i-1,j))~=sign(Image1_LOG5(i+1,j)))
            edge_Image1_LOG5(i,j) = 255;
            rgbImage1_5(i,j,1) = 255;
            rgbImage1_5(i,j,2) = 0;
            rgbImage1_5(i,j,3) = 0;
        elseif (sign(Image1_LOG5(i,j-1))~=sign(Image1_LOG5(i,j+1))) 
            edge_Image1_LOG5(i,j) = 255;
            rgbImage1_5(i,j,1) = 255;
            rgbImage1_5(i,j,2) = 0;
            rgbImage1_5(i,j,3) = 0;
        elseif (sign(Image1_LOG5(i-1,j-1))~=sign(Image1_LOG5(i+1,j+1))) 
            edge_Image1_LOG5(i,j) = 255;
            rgbImage1_5(i,j,1) = 255;
            rgbImage1_5(i,j,2) = 0;
            rgbImage1_5(i,j,3) = 0;
        elseif (sign(Image1_LOG5(i+1,j-1))~=sign(Image1_LOG5(i-1,j+1))) 
            edge_Image1_LOG5(i,j) = 255;
            rgbImage1_5(i,j,1) = 255;
            rgbImage1_5(i,j,2) = 0;
            rgbImage1_5(i,j,3) = 0;
        end 
        
        if (sign(Image1_LOG6(i-1,j))~=sign(Image1_LOG6(i+1,j))) 
            edge_Image1_LOG6(i,j) = 255;
            rgbImage1_6(i,j,1) = 255;
            rgbImage1_6(i,j,2) = 0;
            rgbImage1_6(i,j,3) = 0;
        elseif (sign(Image1_LOG6(i,j-1))~=sign(Image1_LOG6(i,j+1))) 
            edge_Image1_LOG6(i,j) = 255;
            rgbImage1_6(i,j,1) = 255;
            rgbImage1_6(i,j,2) = 0;
            rgbImage1_6(i,j,3) = 0;
        elseif (sign(Image1_LOG6(i-1,j-1))~=sign(Image1_LOG6(i+1,j+1))) 
            edge_Image1_LOG6(i,j) = 255;
            rgbImage1_6(i,j,1) = 255;
            rgbImage1_6(i,j,2) = 0;
            rgbImage1_6(i,j,3) = 0;
        elseif (sign(Image1_LOG6(i+1,j-1))~=sign(Image1_LOG6(i-1,j+1))) 
            edge_Image1_LOG6(i,j) = 255;
            rgbImage1_6(i,j,1) = 255;
            rgbImage1_6(i,j,2) = 0;
            rgbImage1_6(i,j,3) = 0;
        end 
    end
end


figure(1)
subplot(2,3,1);
imshow(Image1_LOG1,[]);
title({['N=6'],['sigma=1']});
subplot(2,3,2);
imshow(Image1_LOG2,[]);
title({['N=11'],['sigma=2']});
subplot(2,3,3);
imshow(Image1_LOG3,[]);
title({['N=15'],['sigma=3']});
subplot(2,3,4);
imshow(Image1_LOG4,[]);
title({['N=21'],['sigma=4']});
subplot(2,3,5);
imshow(Image1_LOG5,[]);
title({['N=25'],['sigma=5']});
subplot(2,3,6);
imshow(Image1_LOG6,[]);
title({['N=31'],['sigma=6']});



