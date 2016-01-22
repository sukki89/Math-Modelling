%   GHCN is a large matrix of global historical temperature data, from 1880 to 2014
%   We downloaded it from ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/v3/grid/
%   The paper describing the dataset is at http://onlinelibrary.wiley.com/doi/10.1029/2011JD016187/pdf

%   The geographic grid  has 36 rows and 72 columns of grid boxes, each covering 5 x 5 degrees.
%   Although the earth is spherical and does not fit a 36 x 72 rectangular grid very well,
%   for simplicity we will use just a rectangular map of the world, with 36 latitude and 72 longitude points.

%   The dataset covers 2014 - 1880 = 135 years, with 12 months per year.
%   As a .csv file, the dataset is a (36 x 12 x 135) x 74 matrix of temperature values,
%   where the first two columns give the year and month.  If you look at the .csv file,
%   you will see exactly how the data looks.

%   The script below reads in the data as a 2D matrix of size (36*12*135) x 74 matrix.
%   It then resizes it into a 4D array, with dimensions  36 x 12 x 135 x 74.
%   The script also fixes the values to be in degrees centigrade.

%   -- D.S. Parker, Fall 2014.

GHCN = csvread('ghcn.csv');

%   The data was artificially shifted to [0, 4500];
%     its range should be [-2500, +2000]/100 = [-25,+20], in degrees Centigrade.
%     Since our focus here is on warming, we ignore temperatures below -5.
%   We omit the year and month in columns 1:2 before scaling:

GHCN_in_centigrade  = (GHCN(:,3:74) - 2500) / 100;

temperature_anomaly = reshape( GHCN_in_centigrade, [36, 12, 135, 72] );   % convert to a 4D matrix, so we can use slices

%   maybe useful:

missing_values = (temperature_anomaly == -25);

number_of_missing_values = sum(sum(sum(sum( missing_values ))));

number_of_all_GHCN_values = prod(size( temperature_anomaly ));

maximum_anomaly_value = max(max(max(max( temperature_anomaly ))));

minimum_anomaly_value = min(min(min(min( temperature_anomaly .*  (~ missing_values) ))));  %  '~' is 'not' in MATLAB

year_month_anomaly = @(Y,M) reshape( temperature_anomaly(:, M, Y-1880+1, :), [36 72])

year_month_missing = @(Y,M) reshape(      missing_values(:, M, Y-1880+1, :), [36 72])

month = { 'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' };

US_latitude  = 9:12
US_longitude = 15:20
my_years = 1900:2013
my_slice = temperature_anomaly( US_latitude, :, my_years - 1880, US_longitude );

total_number_of_grid_squares = length(US_latitude) * length(US_longitude) * 12;
N = total_number_of_grid_squares;
average_US_anomaly_by_year = reshape( sum(sum(sum( my_slice, 4),2),1), [length(my_years) 1] ) / N
plot( my_years, average_US_anomaly_by_year )

