clear all;
folder = '/home/kami/Documents/FALL/modelling/hw2/Homework2Updated/';
csvfile = 'LApower.csv';
filename = strcat(folder,csvfile);
data = csvread( filename, 1, 0 );   

logPowerJul = data(:,7);
logSqMts = data(:,27);
avglogTempJul = data(:,19);
b = logPowerJul - logSqMts;
a = [avglogTempJul.^3, avglogTempJul.^2, avglogTempJul.^1,ones(2322,1)];
x = pinv(a)* b;

% logPowerJan = data(:,1);
% y = logPowerJul - logSqMts;
% x = data(:,13);
plot( data(:,19),logPowerJul - logSqMts,'r*');
hold on;
plot( data(:,19), a*x,'b*');

% b1 = logPowerJul;
% a1 = [ones(2322,1), avglogTempJul, data(:,29), data(:,28), logSqMts];
% x2 = a1 \b;
% b1_recon = a1*x2;
% error = norm(b1_recon)/norm(b1);
% 
% count = 0;
% for i=1:2322
%     if data(i,30) > 50
%         count = count +1;
%         matrix(count,1:7) = [logPowerJul(i,1) - logSqMts(i,1), avglogTempJul(i,1), data(i,25), data(i,26), data(i,28), data(i,29), data(i,38)]; 
%     end
% end
% plotmatrix(matrix);
% 
% corr_data = corr(matrix);