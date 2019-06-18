function [m, A, Eigen_faces] = Training(data_train)

m = mean(data_train,2);
assignin('base','mnya',m);
numberOfTrain = size(data_train,2);
tampung_m = [];  
for i = 1 : numberOfTrain
    tampung_m = [tampung_m m];
end
A = double(data_train) - tampung_m;

L = A'*A;

[V D] = svd(L); 

assignin('base','D',D);

Eigen_vector = [];
for i = 1 : size(V,2) 
    if( D(i,i)>1000 ) 
        Eigen_vector = [Eigen_vector V(:,i)];
    end
end

Eigen_faces = A * Eigen_vector;