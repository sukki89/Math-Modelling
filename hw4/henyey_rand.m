function [x,y]  = henyey_rand( g, samples )
    for i=1:samples
        x(i) = henyey(g);
        numerator = 1-g*g;
        denominator =  (1+g*g-2*g*x(i))^1.5;
        product = numerator/denominator;
        value = 0.5*product;
        y(i) = value;
    end
end

