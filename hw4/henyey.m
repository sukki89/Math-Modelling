function [ y ] = henyey(g )
    cdf = rand(1) ;
    inner = ((cdf*2*g/(1-g^2)) + (1+g^2+2*g)^-0.5)^-2;
    y = (1+ g^2 - inner)/(2*g);
end

