 contents = dir('*.jpg');
 for k = 1:numel(contents)
  filename   = contents(k).name;
  rgbImg     = imread(filename);
  image=(rgbImg);
    FaceDetect = vision.CascadeObjectDetector; 
    FaceDetect.MergeThreshold = 7 ;
    BB = step(FaceDetect, image); 
    imshow(image); 
    for i = 1 : size(BB,1)     
        rectangle('Position', BB(i,:), 'LineWidth', 3, 'LineStyle', '-', 'EdgeColor', 'r'); 
    end 
    for i = 1 : size(BB, 1) 
        data_crop = imcrop(image, BB(i, :));
    end
  gsImg      = rgb2gray(data_crop);
  y          = imresize(gsImg,[390 390]);
  [~,name,~] = fileparts(filename);
  gsFilename = sprintf('%s.jpg', name);
  imwrite(y,gsFilename);
end