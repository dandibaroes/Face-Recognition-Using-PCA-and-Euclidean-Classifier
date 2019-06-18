function name_output = Recognizer(test_img, m, A, Eigen_faces)
img_projected = [];
numberOfTrain = size(A,2);
for k = 1 : numberOfTrain
    tampung = Eigen_faces' * A(:,k); % Projection of centered images into facespace
    img_projected = [img_projected tampung]; 
end

%-------------Project the test image you selected into Eigenfaces space-------------
input_img = imread(test_img);
tampung = input_img(:,:,1);

[index_row index_col] = size(tampung);
tampung_img = reshape(tampung',index_row*index_col,1);

Dif = double(tampung_img)-m; 
Projected_imgTest = Eigen_faces'*Dif; % Test image feature vector

%----------------------- Calculate Euclidean distances and find the
%  index of image of minmum Euclidean distances-------------------- 
Euclidean_distance = [];
for k = 1 : numberOfTrain
    q = img_projected(:,k);
    tampung = (norm(Projected_imgTest - q))^2;
    Euclidean_distance = [Euclidean_distance tampung];
end

[Euc_dist_min , Recognized_idx] = min(Euclidean_distance);
name_output = strcat(int2str(Recognized_idx),'.jpg');
