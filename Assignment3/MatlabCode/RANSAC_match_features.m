function new_H_33 = RANSAC_match_features(grayscaleImage1,grayscaleImage2)
%previous = 3;
%next = 4;
%path1 = [int2str(previous),'.png'];
%path2 = [int2str(next), '.png'];
%rgbImage1 = imread(path1);
%rgbImage2 = imread(path2);
%grayscaleImage1 = single(rgb2gray(rgbImage1)); 
%grayscaleImage2 = single(rgb2gray(rgbImage2)); 

[keypoints1,features1] = sift(grayscaleImage1,'Levels',4,'PeakThresh',5);
[keypoints2,features2] = sift(grayscaleImage2,'Levels',4,'PeakThresh',5);
index1to2 = matchFeatures(features1',features2', 'MatchThreshold', 0.75,'unique',true);
matchedpoints1to2_1 = zeros(size(index1to2,1),2);
matchedpoints1to2_2 = zeros(size(index1to2,1),2);
for i = 1:size(index1to2,1)
    matchedpoints1to2_1(i,1) = keypoints1(1,index1to2(i,1));
    matchedpoints1to2_1(i,2) = keypoints1(2,index1to2(i,1));
    matchedpoints1to2_2(i,1) = keypoints2(1,index1to2(i,2));
    matchedpoints1to2_2(i,2) = keypoints2(2,index1to2(i,2));
end
max_consensus_number = 0;
for i = 1:500000
    consensus_number = 0;
    chosen = randi(size(matchedpoints1to2_1,1),1,4);
    x1 = matchedpoints1to2_1(chosen(1,1),1); y1 = matchedpoints1to2_1(chosen(1,1),2); x1_prime = matchedpoints1to2_2(chosen(1,1),1); y1_prime = matchedpoints1to2_2(chosen(1,1),2);
    x2 = matchedpoints1to2_1(chosen(1,2),1); y2 = matchedpoints1to2_1(chosen(1,2),2); x2_prime = matchedpoints1to2_2(chosen(1,2),1); y2_prime = matchedpoints1to2_2(chosen(1,2),2);
    x3 = matchedpoints1to2_1(chosen(1,3),1); y3 = matchedpoints1to2_1(chosen(1,3),2); x3_prime = matchedpoints1to2_2(chosen(1,3),1); y3_prime = matchedpoints1to2_2(chosen(1,3),2);     
    x4 = matchedpoints1to2_1(chosen(1,4),1); y4 = matchedpoints1to2_1(chosen(1,4),2); x4_prime = matchedpoints1to2_2(chosen(1,4),1); y4_prime = matchedpoints1to2_2(chosen(1,4),2);
    row_1 = [x1,y1,1,0,0,0,-x1_prime*x1,-x1_prime*y1,-x1_prime;0,0,0,x1,y1,1,-y1_prime*x1,-y1_prime*y1,-y1_prime];
    row_2 = [x2,y2,1,0,0,0,-x2_prime*x2,-x2_prime*y2,-x2_prime;0,0,0,x2,y2,1,-y2_prime*x2,-y2_prime*y2,-y2_prime];
    row_3 = [x3,y3,1,0,0,0,-x3_prime*x3,-x3_prime*y3,-x3_prime;0,0,0,x3,y3,1,-y3_prime*x3,-y3_prime*y3,-y3_prime];
    row_4 = [x4,y4,1,0,0,0,-x4_prime*x4,-x4_prime*y4,-x4_prime;0,0,0,x4,y4,1,-y4_prime*x4,-y4_prime*y4,-y4_prime];
    matrix_a = [row_1;row_2;row_3;row_4];
    H = null(matrix_a);
    if size(H,2)>1
        continue;
    end
    H_33 = [H(1,1),H(2,1),H(3,1); H(4,1),H(5,1),H(6,1); H(7,1),H(8,1),H(9,1)];
    RANSAC_matchedpoints1to2_1 = zeros(size(matchedpoints1to2_1,1),2);
    RANSAC_matchedpoints1to2_2 = zeros(size(matchedpoints1to2_2,1),2);
    for j = 1:size(matchedpoints1to2_1,1)
        w_prime = H_33*[matchedpoints1to2_1(j,1);matchedpoints1to2_1(j,2);1];
        prime = w_prime/w_prime(3,1);
        distance = sqrt((matchedpoints1to2_2(j,1)-prime(1,1))^2+(matchedpoints1to2_2(j,2)-prime(2,1))^2);
        if distance<3
            consensus_number = consensus_number+1;
            RANSAC_matchedpoints1to2_1(consensus_number,1) = matchedpoints1to2_1(j,1);
            RANSAC_matchedpoints1to2_1(consensus_number,2) = matchedpoints1to2_1(j,2);
            RANSAC_matchedpoints1to2_2(consensus_number,1) = matchedpoints1to2_2(j,1);
            RANSAC_matchedpoints1to2_2(consensus_number,2) = matchedpoints1to2_2(j,2);
        end
  
    end
    if consensus_number>max_consensus_number
        RANSAC_matchedpoints1to2_1_result = RANSAC_matchedpoints1to2_1(1:consensus_number,1:2);
        RANSAC_matchedpoints1to2_2_result = RANSAC_matchedpoints1to2_2(1:consensus_number,1:2);
        max_consensus_number = consensus_number;
    end
    if consensus_number>size(matchedpoints1to2_1,1)*0.8
        RANSAC_matchedpoints1to2_1_result = RANSAC_matchedpoints1to2_1(1:consensus_number,1:2);
        RANSAC_matchedpoints1to2_2_result = RANSAC_matchedpoints1to2_2(1:consensus_number,1:2);
        break;
    end
    
    if i == 500000
        'No Convergence'
        no_convergence = max_consensus_number/size(matchedpoints1to2_1,1)
    end

end
new_matrix_a =[0,0,0,0,0,0,0,0,0];
for i = 1:size(RANSAC_matchedpoints1to2_1_result,1)
    new_x = RANSAC_matchedpoints1to2_1_result(i,1);
    new_y = RANSAC_matchedpoints1to2_1_result(i,2);
    new_x_prime = RANSAC_matchedpoints1to2_2_result(i,1);
    new_y_prime = RANSAC_matchedpoints1to2_2_result(i,2);
    new_matrix_a = [new_matrix_a; new_x,new_y,1,0,0,0,-new_x_prime*new_x,-new_x_prime*new_y,-new_x_prime];
    new_matrix_a = [new_matrix_a; 0,0,0,new_x,new_y,1,-new_y_prime*new_x,-new_y_prime*new_y,-new_y_prime];
end
new_matrix_a(1,:) = [];
[eigVector,eigValue] = eig(new_matrix_a'*new_matrix_a);
eigValue1 = diag(eigValue);
[~, min_position] = min(eigValue1');
new_H = eigVector(:,min_position);
new_H_33 = [new_H(1,1),new_H(2,1),new_H(3,1); new_H(4,1),new_H(5,1),new_H(6,1); new_H(7,1),new_H(8,1),new_H(9,1)];
figure; 
%showMatchedFeatures(grayscaleImage2,grayscaleImage1,RANSAC_matchedpoints1to2_2_result,RANSAC_matchedpoints1to2_1_result,'montage');
%titleString = ['RANSAC Matched Features Between Images ', int2str(previous), ' and ', int2str(next)];

%title(titleString);
