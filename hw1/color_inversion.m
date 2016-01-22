function [ Y ] = color_inversion( A )
% inverts the color in the image
    [R,G,B] = image2rgb(A);
    R1 = 255 - R;
    G1 = 255 - G;
    B1 = 255 - B;
    Y = rgb2image(R1,G1,B1);
end

