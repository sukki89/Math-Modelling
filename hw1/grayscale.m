function [ G ] = grayscale( A )
%Converts an image to gray scale
% R = G = B
    [R,G,B] = image2rgb(A);
    G = cat(3, (R+G+B)/3, (R+G+B)/3, unit8((R+G+B)/3);
end

