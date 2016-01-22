function [ D ] = darken(A,t )
% darkens the image
    hsvConverted = rgb2hsv(A);
    H = double(hsvConverted(:,:,1));
    S = double(hsvConverted(:,:,2));
    V = double(hsvConverted(:,:,3));
    V = t.* V;
    hsvDarkened = cat(3,H,S,V);
    D = hsv2rgb(hsvDarkened);
end

