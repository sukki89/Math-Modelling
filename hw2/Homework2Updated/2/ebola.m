folder = '/home/kami/Documents/FALL/modelling/hw2/Homework2Updated/';
csvfile = { 'guinea.csv' 'liberia.csv' 'sierra-leone.csv' };

for i=1:3
   filename = strcat(folder,csvfile{i});
   data = csvread( filename, 1, 0 );
   %figure
   time = 1:size(data,1)
   [rows,cols] = size(data);
   for j=1:rows
        dateNum(j,i) = datenum(2014,data(j,1),data(j,2)) - datenum(2014,data(1,1),data(1,2));
   end
   %plot( time, data(:,3), 'r.-', time, data(:,4), 'b.-')
   %title( csvfile{i}, 'FontSize', 24 )
end

% guinea
filename = strcat(folder,csvfile{1});
data = csvread( filename, 1, 0 );
guinea_times = [dateNum(:,1).^3, dateNum(:,1).^2, dateNum(:,1).^1];
guinea_times(:,4) = guinea_times(:,3) ./ guinea_times(:,3);
gcases_poly = guinea_times \ data(:,3);
gdeath_poly = guinea_times \ data(:,4) ;
guinea_times_expo = dateNum(:,1);
guinea_times_expo(:,2) = guinea_times_expo(:,1) ./ guinea_times_expo(:,1);
guinea_times_expo(1,2) = 1;
gcases_expo = pinv(guinea_times_expo) *  log(data(:,3));
gdeath_expo = pinv(guinea_times_expo) *  log(data(:,4));
figure;
plot(dateNum(:,1),data(:,3));
hold all
plot(dateNum(:,1),guinea_times*gcases_poly);
hold off;
plot(dateNum(:,1),exp(guinea_times_expo*gcases_expo));
title('Guinea Cases');
hold off;
figure;
plot(dateNum(:,1),data(:,4));
hold all
plot(dateNum(:,1),guinea_times*gdeath_poly);
title('Guinea Deaths');
hold off;

% %liberia
%  filename = strcat(folder,csvfile{2});
%  ldata = csvread( filename, 1, 0 );
%  liberia_times = [dateNum(1:37,2).^3, dateNum(1:37,2).^2, dateNum(1:37,2).^1];
%  liberia_times(:,4) = liberia_times(:,3) ./ liberia_times(:,3);
%  lcases_poly = liberia_times \ ldata(:,3);
%  ldeath_poly = liberia_times \ ldata(:,4) ;
%  liberia_times_expo = dateNum(1:37,1);
%  liberia_times_expo(:,2) = liberia_times_expo(:,1) ./ liberia_times_expo(:,1);
%  lcases_expo = liberia_times_expo \ ldata(:,3);
%  ldeath_expo = liberia_times_expo \ ldata(:,4);
%  lcases_expo = liberia_times_expo \ ldata(:,3);
%  ldeath_expo = liberia_times_expo \ ldata(:,4);
%  figure;
%  plot(dateNum(1:37,2),ldata(:,3)); 
%  hold all
%  plot(dateNum(1:37,2),liberia_times*lcases_poly);
%  title('Liberia Cases');
%  hold off;
%  figure;
% plot(dateNum(1:37,2),ldata(:,4));
% hold all
% plot(dateNum(1:37,2),liberia_times*ldeath_poly);
% title('Liberia Deaths');
% hold off;
% 
% %sierra-leone
%  filename = strcat(folder,csvfile{3});
%  sdata = csvread( filename, 1, 0 );
%  sierra_times = [dateNum(1:41,3).^3, dateNum(1:41,3).^2, dateNum(1:41,3).^1];
%  sierra_times(:,4) = sierra_times(:,3) ./ sierra_times(:,3);
%  scases_poly = sierra_times \ sdata(:,3);
%  sdeath_poly = sierra_times \ sdata(:,4) ;
%  sierra_times_expo = dateNum(1:37,1);
%  sierra_times_expo(:,2) = sierra_times_expo(:,1) ./ sierra_times_expo(:,1);
%  scases_expo = sierra_times_expo \ ldata(:,3);
%  sdeath_expo = sierra_times_expo \ ldata(:,4);
%  figure;
%  plot(dateNum(1:41,3),sdata(:,3)); 
%  hold all
%  plot(dateNum(1:41,3),sierra_times*scases_poly);
%   title('Sierra Cases');
%  hold off;
%  figure;
% plot(dateNum(1:41,3),sdata(:,4));
% hold all
% plot(dateNum(1:41,3),sierra_times*sdeath_poly);
% title('Sierra Deaths');
% hold off;
 


