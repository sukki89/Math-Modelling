clear all;
folder = '/home/kami/Documents/FALL/modelling/hw2/Homework2Updated/';
csvfile = { 'guinea.csv' 'liberia.csv' 'sierra-leone.csv' };

for i=3:3
   filename = strcat(folder,csvfile{i});
   clear data time dateNum;
   data = csvread( filename, 1, 0 );
   %figure
   time = 1:size(data,1);
   [rows,cols] = size(data);
   for j=1:rows
        dateNum(j) = datenum(2014,data(j,1),data(j,2)) - datenum(2014,data(1,1),data(1,2));
   end
    times = [dateNum(:).^4, dateNum(:).^3, dateNum(:).^2, dateNum(:).^1];
    times(:,5) = times(:,3) ./ times(:,3);
    times(1,5) = 1;
    cases_poly = pinv(times)* data(:,3);
    death_poly = pinv(times) * data(:,4) ;
    times_expo = dateNum(:);
    times_expo(:,2) = times_expo(:,1) ./ times_expo(:,1);
    times_expo(1,2) = 1;
    cases_expo = pinv(times_expo) * log(data(:,3));
    log_values = log(data(:,4));
    log_values(1) = 0;
    death_expo = pinv(times_expo) * log_values;
    figure;
    %Plot cases poly and expo
    hold all;
    plot(dateNum(:),data(:,3),'g*');
    plot(dateNum(:),times*cases_poly,'b-');
    plot(dateNum(:),exp(times_expo*cases_expo),'r');
    r_cases_poly = norm((times*cases_poly) - data(:,3));
    r_cases_expo = norm(exp(times_expo*cases_expo) - (data(:,3)));
    
    %Plot deaths poly and expo
    plot(dateNum(:),data(:,4),'g*');
    plot(dateNum(:),times*death_poly,'b-');
    plot(dateNum(:),exp(times_expo*death_expo),'r');
    r_death_poly = norm((times*death_poly) - data(:,4));
    r_death_expo = norm(exp(times_expo*death_expo) - (data(:,4)));
    
    title(strcat(csvfile{i},sprintf(' Erorr: Cases poly-%d',r_cases_poly),sprintf('; Cases expo-%d',r_cases_expo),sprintf('; Death expo-%d',r_death_expo),sprintf('; Death poly-%d',r_death_poly)));
    legend('Cases curve','Cases poly', 'Cases expo','Death curve','Death poly','Death expo');
    hold off;

   %plot( time, data(:,3), 'r.-', time, data(:,4), 'b.-')
   %title( csvfile{i}, 'FontSize', 24 )
end
