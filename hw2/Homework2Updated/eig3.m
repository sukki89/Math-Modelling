function [ female_face, male_male ] = eigFaces( loc, face_features, k  ) 
	%row wise
	% Read all the images

	filelist = readdir(loc);
	cf = 0; cm = 0; count = 0;
	for i=1:177
	 x = imread(strcat(loc,filelist(i+2,1))(1,1){1});
	 a = reshape(x,1,64*64);
         if  strcmp(face_features{i,2}, 'Female') && strcmp(face_features{i,3}, 'Blue')
           cf += 1;
	   count += 1;
      	   images_female_blue(cf) = count;
	   images(count,:) = a;
	 end 
	 
 	 if  strcmp(face_features{i,2}, 'Male') && strcmp(face_features{i,3}, 'Blue')
           cm += 1;
	   count += 1;
      	   images_male_blue(cm) = count;
	   images(count,:) = a;
	 end
	end

	%Calculate mean
	[rows,cols] = size(images);
	for i=1:cols
	  mean(i) = round(sum(images(:,i)/rows));
	end
	
	%Create caricature
	[rows,cols] = size(images);
	for i=1:rows
	caricature(i,:) =  images(i,:) - mean(1,:);
	end

	replacement = cov(caricature);
	[u,l,v] = svds(replacement,k);
	c = v' * double(caricature');
	[rows,cols] = sizeof(c)

	max = 0;
	[rows,cols] = size(images_female_blue);
	for i=1:rows
	 index = images_female_blue(i,1);
	 coeff = norm(c(:,index));
	 if (max < coeff)
	   max = coeff;
           coeff_female = c(:,index);
           %female_face = images(index,:);
          end
	end
	
	female_face = mean + v' * coeff_female;
	figure
	im = reshape(female_face,64,64);
	imshow(im);

	max = 0;
	[rows,cols] = size(images_male_blue);
	for i=1:rows
	 index = images_male_blue(i,1);
	 coeff = norm(c(:,index));
	 if (max < coeff)
	   max = coeff;
  	   coeff_male = c(:,index);
           %male_face = images(index,:);
          end
	end

	male_face = mean + v' * coeff_male;
	figure
	im = reshape(male_face,64,64);
	imshow(im);
end


