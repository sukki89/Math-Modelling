clear all;
folder = '/home/kami/Documents/FALL/modelling/hw2/Homework2Updated/';
csvfile = 'mpg.csv';
filename = strcat(folder,csvfile);
data = csvread( filename, 1, 0 );
mpg = data(:,8);
displacement = data(:,6);
%part 1: coefficients and error
A = [log(displacement), ones(7287,1)];
x = A \ log(mpg)
A1 = A*x ;
norm(A1-log(mpg));
R2_a = norm(A1)/norm(log(mpg));

cylinders = data(:,5);
classsize = data(:,10);
guzzler = data(:,11);
A_b = [ones(7287,1), displacement, cylinders, classsize, guzzler];
mpg_1 = mpg.^-1;
x_b = A_b \ mpg_1
A1_b = A_b * x_b;
norm(mpg_1-A1_b)
R2_b = norm(A1_b)/norm(mpg_1);



%%%%Linear Model with highest R-Squared Value

%Geting the left out data

origin=data(:,3);
auto_trans=data(:,4);
drive=data(:,7);

A=[];

r_max=0;

flag=0;

for i=0:1 %origin
    for j=0:1 %auto_trans
        for k=0:1 %cyl
            for l=0:1 %displ
                for m=0:1 %drive
                    for n=0:1 %cl_sz
                        A=[];
                        if(i==1)
                            A=[A origin];flag=1;
                        end
                        if(j==1)
                            A=[A auto_trans];flag=1;
                        end
                        if(k==1)
                            A=[A cylinders];flag=1;
                        end
                        if(l==1)
                            A=[A displacement];flag=1;
                        end
                        if(m==1)
                            A=[A drive];flag=1;
                        end
                        if(n==1)
                            A=[A classsize];flag=1;
                        end
                        if(flag==1)
                            A=[A classsize.^0]; %Just adding the 1s
                            y=mpg.^-1;
                            A_pseudo=pinv(A);
                            x_coeff=A_pseudo*y;
                            new_y=A*x_coeff;
                            r_square_six=norm(new_y)/norm(y);
                            if(r_square_six>r_max)
                                r_max=r_square_six;
                                r_set=[i j k l m n];
                            end
                            flag=0;
                        end
                    end
                end
            end
        end
    end
end
disp(sprintf('Maximum R-Squared Error for 1/(cityMPG): %f',r_max));



origin = data(:,3);
drive = data(:,7);
autotrans = data(:,4);
A_3 = [origin, autotrans, cylinders, displacement, drive, classsize];


year = data(:,2);
A_d = [cylinders, displacement, drive, classsize, year, mpg_1];
A_cor = corr(A_d);
[u,s,v] = svd(A_cor);
for i=1:6
  variance(i) = s(i,i)/trace(s);
end
plot(1:6, variance);
pc = A_d * u(:,1:3);
% scatter3(pc(:,1),pc(:,2),pc(:,3));
% figure
% hold all;
color = ['r','g','b'];

c1=0;c2=0;c3=0;
for i=1:rows(pc)
     if origin(i) == 1
         c1 = c1+1;
         color1(c1,:) = pc(i,:);
     elseif origin(i) == 2
         c2 = c2 +1;
         color2(c2,:) = pc(i,:);
     else
         c3 = c3 + 1;
         color3(c3,:) = pc(i,:);
     end
end


plot3(color3(:,1),color3(:,2),color3(:,3),'g.');
hold on
plot3(color2(:,1),color2(:,2),color2(:,3),'b.');
hold on
plot3(color1(:,1),color1(:,2),color1(:,3),'r.');
% 
% hold all
% scatter3(color3(:,1),color3(:,2),color3(:,3),'g');
% scatter3(color2(:,1),color2(:,2),color2(:,3),'b');
% scatter3(color1(:,1),color1(:,2),color1(:,3),'r');
% 
% 
%   
