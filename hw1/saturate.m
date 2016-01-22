function [ S ] = saturate( A,t )
%image saturation
   grayScale = grayscale(A);
   S = interpolate(double(A),double(grayScale),t);
end

