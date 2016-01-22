function [] = mov( A,B,n)
    F(n) = struct('cdata',[],'colormap',[]);
    for j = 1:n
        C = interpolate(double(A),double(B),j-1/n);
        imshow(C);
        drawnow
        F(j) = getframe;
    end
    movie(F);
end


  