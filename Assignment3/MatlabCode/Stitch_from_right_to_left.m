function stitchedImage = Stitch_from_right_to_left(Image1,Image2)

zeroMatrix = zeros(size(Image2,1),size(Image2,2));
stitchedImage = [zeroMatrix,Image1];
%index1to2 = match_features(0, 1);
H = RANSAC_match_features(Image1,Image2);
for i = 1:size(Image2,1)
    for j = 1: size(Image2,2)
        position_in_left = H*[j-size(Image1,2)-1;i;1];
        position_in_left = position_in_left/position_in_left(3,1);
        i_in_left = position_in_left(2,1);
        j_in_left = position_in_left(1,1);
        if round(i_in_left)>0 && round(i_in_left)<=size(Image2,1) && round(j_in_left)>0 && round(j_in_left)<=size(Image2,2)
            stitchedImage(i,j) = Image2(round(i_in_left),round(j_in_left));
        end
        
    end
end

for j = 1:size(Image2,2)
    number_of_zeros = 0;
    for i = 1:size(Image2,1)
        if stitchedImage(i,j) <1
            number_of_zeros = number_of_zeros +1;
        end
    end
    if number_of_zeros<5
        break;
    end
end
stitchedImage = stitchedImage(:,j:size(Image1,2)+size(Image2,2));