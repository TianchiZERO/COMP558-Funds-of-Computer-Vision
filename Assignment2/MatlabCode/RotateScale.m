function returnImage = RotateScale(OriginImage, centeri, centerj, theta, s)
Image = imresize(OriginImage,s);
newcenteri = round(centeri*s);
newcenterj = round(centerj*s);
%VoidMatrix = zeros(ceil(size(Image,1)*2*sqrt(2)), ceil(size(Image,1)*2*sqrt(2))); 
%centeriVoidMatrix = round(size(VoidMatrix,1)/2);
%centerjVoidMatrix = round(size(VoidMatrix,2)/2);

%for i = 1:size(Image,1)
 %   for j = 1:size(Image,2)
  %      VoidMatrix(round(centeriVoidMatrix-sind(theta)*(j-newcenterj)-cosd(theta)*(newcenteri-i)), round(centerjVoidMatrix+cosd(theta)*(j-newcenterj)-sind(theta)*(newcenteri-i))) = Image(i,j);   
 %   end
%end
%newImage = VoidMatrix;

matrix = zeros(2*max([newcenteri size(Image,1)-newcenteri]), 2*max([newcenterj size(Image,2)-newcenterj]));
for i = 1:size(Image,1)
    for j = 1:size(Image,2)
        if newcenteri<size(Image,1)-newcenteri && newcenterj<size(Image,2)-newcenterj
            matrix(i+size(Image,1)-2*newcenteri,j+size(Image,2)-2*newcenterj) = Image(i,j);
        elseif newcenteri<size(Image,1)-newcenteri && newcenterj>size(Image,2)-newcenterj
            matrix(i+size(Image,1)-2*newcenteri,j) = Image(i,j);
        elseif newcenteri>size(Image,1)-newcenteri && newcenterj<size(Image,2)-newcenterj
            matrix(i,j+size(Image,2)-2*newcenterj) = Image(i,j);
        elseif newcenteri==size(Image,1)-newcenteri && newcenterj<size(Image,2)-newcenterj
            matrix(i,j+size(Image,2)-2*newcenterj) = Image(i,j);
        elseif newcenteri<size(Image,1)-newcenteri && newcenterj==size(Image,2)-newcenterj
            matrix(i+size(Image,1)-2*newcenteri,j) = Image(i,j);
        else
            matrix(i,j) = Image(i,j);
        end
    end
end

newImage = imrotate(matrix,theta);
if size(newImage,1) <= size(OriginImage,1)
    add = zeros(1+ceil(0.5*size(OriginImage,1)-0.5*size(newImage,1)), size(newImage,2));
    newImage = [add; newImage];
    newImage = [newImage; add];
end

if size(newImage,2) <= size(OriginImage,2)
    add = zeros(size(newImage,1), 1+ceil(0.5*size(OriginImage,2)-0.5*size(newImage,2)));
    newImage = [add newImage];
    newImage = [newImage add];
end

newcenteri = round(size(newImage,1)/2);
newcenterj = round(size(newImage,2)/2);
returnImage = newImage(newcenteri-round(size(OriginImage,1)/2)+1:newcenteri+round(size(OriginImage,1)/2), newcenterj-round(size(OriginImage,2)/2)+1:newcenterj+round(size(OriginImage,2)/2));

end
