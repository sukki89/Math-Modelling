function [ percentage ] = eigFaces( loc, face_features ) 
	%row wise
	% Read all the images

	filelist = readdir(loc);
	cf = 0; cm = 0;
	for i=1:168
	 x = imread(strcat(loc,filelist(i+2,1))(1,1){1});
	 a = reshape(x,1,64*64);
	 images(i,:) = a;
         if  strcmp(face_features{i,2}, 'Female') && strcmp(face_features{i,3}, 'Blue')
           cf += 1;
      	   images_female_blue(cf,:) = a;
	 end 
	 
 	 if  strcmp(face_features{i,2}, 'Male') && strcmp(face_features{i,3}, 'Blue')
           cm += 1;
      	   images_male_blue(cm,:) = a;
	 end
	end

	%Calculate mean
	[rows,cols] = size(images_female_blue);
	for i=1:cols
	  mean_f(i) = round(sum(images_female_blue(:,i)/rows));
	end
	[rows,cols] = size(images_male_blue);
	for i=1:cols
	  mean_m(i) = round(sum(images_male_blue(:,i)/rows));
	end

	true =0; false =0;
	for i=1:168	  
	  diff_f = norm(double(images(i,:)) - mean_f);
	  diff_m = norm(double(images(i,:)) - mean_m);
	  if (strcmp(face_features{i,2}, 'Male') && diff_m < diff_f) || ( strcmp(face_features{i,2}, 'Female') && diff_f<diff_m)
		true += 1;
          else
		false +=1;
          end
         end
	percent = true/(true+false) * 100
end