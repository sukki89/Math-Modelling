function [ avgFace, ksingularValues, eigenFaces ] = eigFaces( loc, k ) 
for i=1:150
 x = imread(filenames(i).name);
 a = reshape(x,256*256,1);
 image_matrix_real(:,i) = a;
 end

end

