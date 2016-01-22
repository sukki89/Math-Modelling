function [] = ghcn_hotplot()
    GHCN = csvread('/home/kami/Documents/FALL/modelling/hw1/Homework1/ghcn.csv');
    GHCN_in_centigrade  = (GHCN(:,3:74) - 2500) / 100;
    temperature_anomaly = reshape( GHCN_in_centigrade, [36, 12, 135, 72] );   
    US_latitude  = 1:36;
    US_longitude = 1:72;
    my_years = 1880:2014;
    my_slice = temperature_anomaly( US_latitude, :, my_years - 1879, US_longitude );
    
    colormap(hot)
    F(114) = struct('cdata',[],'colormap',[]);
    total_number_of_grid_squares = length(US_latitude) * length(US_longitude) * 12;
    N = total_number_of_grid_squares;
    monthly_anamoly = sum(sum(my_slice, 4),1);
    
    for n = 1:134
      yearly_matrix(1:12) = monthly_anamoly(:,:,n);
      july_anomaly(n) = yearly_matrix(7)/N;
      if july_anomaly(n) < -5
         july_anomaly(n) = -5
      end
      plot( my_years(1:n), july_anomaly);
      F(n) = getframe;
    end
    movie(F);
    xlim([1900,2010]);     
end
