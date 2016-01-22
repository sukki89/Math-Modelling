function [ Y ] = YCbCr( A )
%YCbCr
    T = [0.29900, 0.58700, 0.11400; -0.16874,-0.33126,0.50000;0.50000,-0.41869,-0.08131];
    v = [0;128;128];
    [R,G,B] = image2rgb(A);
    [rows,cols] = size(R);
    for r = 1:rows
        for c = 1:cols
            color = [R(r,c);G(r,c);B(r,c)];
            color = T*color;
            color = color + v;
            R1(r,c) = color(1);
            G1(r,c) = color(2);
            B1(r,c) = color(3);         
        end       
    end   
    Y = rgb2image(R1,G1,B1);
    imshow(Y);
end

