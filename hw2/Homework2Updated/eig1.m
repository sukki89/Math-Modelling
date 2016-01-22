function [ avgFace, ksingularValues, eigenFaces ] = eigFaces( loc,s,k ) 
	%row wise
	% Read all the images

	filelist = readdir(loc);
	for i=1:s
	 x = imread(strcat(loc,filelist(i+2,1))(1,1){1});
	 a = reshape(x,1,64*64);
	 images(i,:) = a;
	end

	%Calculate mean
	[rows,cols] = size(images);
	for i=1:cols
	  mean(i) = round(sum(images(:,i)/rows));
	end

	im = reshape(mean,64,64);
	im=(im-min(im(:)))/(max(im(:))-min(im(:)));
	imshow(im);
        avgFace = im;
	
	%Create caricature
	for i=1:rows
	caricature(i,:) =  images(i,:) - mean(1,:);
	end

	replacement = cov(caricature);
	[u,l,v] = svds(replacement,k);
	ksingularValues = diag(l)
	eigenFaces = v;

	for i=1:k
	  %figure
          subplot(2,2,i);
	  im = reshape(eigenFaces(:,i),64,64);
	  im=(im-min(im(:)))/(max(im(:))-min(im(:)));
	  imshow(im);
	  axis off
	end
end
