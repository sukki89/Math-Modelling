function [ hits_array, misses_array ] = monte_carlo( total_points  )
    hits = 0;
    misses = 0;
    g = 0.25;
    for i=1:total_points
        x = 2*rand -1;
        y = rand + 0.2;
        numerator = 1-g*g;
        denominator =  (1+g*g-2*g*x)^1.5;
        product = numerator/denominator;
        value = 0.5*product;
        if (value - y >= 0)
            hits = hits+1;
            hits_array(hits,1) = x;
            hits_array(hits,2) = y;
        else
            misses = misses+1;
            misses_array(misses,1) = x;
            misses_array(misses,2) = y;
        end
    end
end

