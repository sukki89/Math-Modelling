function [ x,y ] = henyey_greenstein( g )
    j=1;
    i=-1;
    g
    while(i<=1)
        i
        x(j) = i;
        clear numerator;
        clear denominator;
        numerator = 1-g*g;
        denominator =  (1+g*g-2*g*i)^1.5;
        product = numerator/denominator;
        value = 0.5*product;
        y(j) = value;
        j = j+1;
        i = i+0.1;
    end
end

