function  [ time adjusted_close ] = read_stock( CSV_Filename )

%%% data = csvread( CSV_Filename, 1, 0 );  %  1,0  =>  skip the first (header) record
%%% data = importdata( CSV_Filename );

fid = fopen( CSV_Filename );
header = fgetl( fid );
data = textscan(fid,'%s%f%f%f%f%f%f','Delimiter',',','EmptyValue',-Inf);
fclose(fid);

s = data{1};
closing_price = data{7};

n = length(s);
time = zeros(n,1);
adjusted_close = zeros(n,1);

month_days = [ 0 31 28 31 30 31 30 31 31 30 31 30 ];
cumulative_month_days = cumsum( month_days );

for i=1:n
   Date = sscanf( s{n+1-i}, '%f-%f-%f' );
   time(i) = (Date(3) + cumulative_month_days(floor(Date(2))) + 365 * Date(1)) / 365;
   adjusted_close(i) = closing_price(n+1-i);
end

figure
plot(time, adjusted_close)
xlabel(sprintf('adjusted closing price from %s',CSV_Filename))
