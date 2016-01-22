function [ avgFace, ksingularValues, eigenFaces ] = eigFaces( loc,k ) 
	%row wise
	% Read all the images

	filelist = readdir(loc);
	cf =0; cm=0;
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
	[rows,cols] = size(images_male_blue);
	for i=1:cols
	  mean_m(i) = round(sum(images_male_blue(:,i)/rows));
	end

	[rows,cols] = size(images_female_blue);
	for i=1:cols
	  mean_f(i) = round(sum(images_female_blue(:,i)/rows));
	end

	%Create caricature
	for i=1:rows
	caricature_f(i,:) =  images_female_blue(i,:) - mean_f(1,:);
	end

	for i=1:rows
	caricature_m(i,:) =  images_male_blue(i,:) - mean_m(1,:);
	end

	replacement = cov(caricature_f);
	[uf,lf,vf] = svds(replacement,k);
	ksingularValues = diag(lf)
	eigenFaces = vf;

	replacement = cov(caricature_m);
	[um,lm,vm] = svds(replacement,k);
	ksingularValues = diag(lm)
	eigenFaces = vm;

	for i=1:k
	  figure
          %subplot(6,5,i);
	  im = reshape(eigenFaces(:,i),64,64);
	  im=(im-min(im(:)))/(max(im(:))-min(im(:)));
	  imshow(im);
	  axis off
	end
end
