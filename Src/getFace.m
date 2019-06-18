function tampung_dataTrain = getFace(data_trainLoc)
img_list = dir(strcat(data_trainLoc,'\*.jpg'));
tampung_dataTrain = [];
for imidx = 1:length(img_list)

    path = strcat(data_trainLoc,strcat('\',int2str(imidx),'.jpg'));
    img = imread(path);
    [irow icol] = size(img);
    temp = reshape(img',irow*icol,1);
    tampung_dataTrain = [tampung_dataTrain temp];
end