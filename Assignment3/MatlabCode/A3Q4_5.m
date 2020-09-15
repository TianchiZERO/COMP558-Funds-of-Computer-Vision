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
close all;
S01 = Stitch_from_right_to_left(grayscaleImage0,grayscaleImage1);
%S12 = Stitch_from_left_to_right(grayscaleImage1,grayscaleImage2);

S23 = Stitch_from_left_to_right(grayscaleImage2,grayscaleImage3);
%S34 = Stitch_from_left_to_right(grayscaleImage3,grayscaleImage4);

S45 = Stitch_from_left_to_right(grayscaleImage4,grayscaleImage5);
S2345 = Stitch_from_right_to_left(S23,S45);
S = Stitch_from_left_to_right(S01,S2345);

close all;
figure(1);
imshow(S,[]);





