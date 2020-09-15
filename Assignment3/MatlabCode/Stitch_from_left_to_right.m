function stitchedImage = Stitch_from_left_to_right(Image1,Image2)

zeroMatrix = zeros(size(Image1,1),size(Image1,2));
stitchedImage = [Image2,zeroMatrix];
%index1to2 = match_features(0, 1);
H = RANSAC_match_features(Image1,Image2);
for i = 1:size(Image1,1)
    for j = 1: size(Image1,2)
        position = H\[j+size(Image2,2);i;1];
        position = position/position(3,1);
        i_in = position(2,1);
        j_in = position(1,1);
        if round(i_in)>0 && round(i_in)<=size(Image1,1) && round(j_in)>0 && round(j_in)<=size(Image1,2)
            stitchedImage(i,j+size(Image2,2)) = Image1(round(i_in),round(j_in));
        end
        
    end
end

for j = 1:size(Image1,2)
    number_of_zeros = 0;
    for i = 1:size(Image1,1)
        if stitchedImage(i,j+size(Image2,2)) <1
            number_of_zeros = number_of_zeros +1;
        end
    end
    if number_of_zeros>5
        break;
    end
end
stitchedImage = stitchedImage(:,1:j+size(Image2,2));