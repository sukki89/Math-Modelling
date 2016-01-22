
function [R,G,B] = image2rgb(A)
    R = double(A(:,:,1));
    G = double(A(:,:,2));
    B = double(A(:,:,3));
end
    
    




