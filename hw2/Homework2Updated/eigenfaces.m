Face = imread('face000.bmp');
figure
subplot(1,2,1)
imshow(Face)
title('initial image -- no approximation')

X = double(Face);        % convert unit8 image to double so we can operate on it
[U,S,V] = svd(X);
sigma = diag(S);

% find the index k such that sigma_k has percentage less than 1 percent
sigma_percentage = sigma / sum(sigma);

k = find( sigma_percentage < 0.01, 1 );

S_k = S(1:k, 1:k);       % k-th order approximation
U_k = U(:, 1:k);
V_k = V(:, 1:k);

X_k = U_k * S_k * V_k';

Face_k = uint8(X_k);     % convert matrix back to a uint8 image
subplot(1,2,2)
imshow(Face_k)
title(sprintf('k-th order approximation of image (k = %d)',k))

%-------------------------------
%  
%  function scree_plot( sigma, percent )
%     plot( sigma, 'b.' )
%     hold on
%     k = max(size(sigma))
%     plot( [0 k], [percent percent] * sum(sigma), 'r-' )
%     title('a "scree plot":  singular values of the face matrix X')
%     xlabel('the red line is 1 percent of the total of all singular values')
%     hold off
%  end
%  
%-------------------------------

scree_plot( sigma, 0.01 )

%-------------------------------
%  
%  function X_k = kthOrderApproximation(X, k)
%     [U,S,V] = svds(X, k);
%     U_k = U(:, 1:k);
%     V_k = V(:, 1:k);
%     S_k = S(1:k, 1:k);
%     X_k = U_k * S_k * V_k';
%  end
%  
%-------------------------------

Face_10 = uint8( kthOrderApproximation(X, 10) );
Face_5  = uint8( kthOrderApproximation(X, 5) );

figure
subplot(1,2,1)
imshow(Face_10)
title('10-th order approximation of image')
subplot(1,2,2)
imshow(Face_5)
title('5-th order approximation of image')

%-------------------------------

 %----------------------------------------------------------------------------
 %       Useful functions for converting  images  <-->  vectors
 %----------------------------------------------------------------------------
 row = 64
 col = 64
 
 image_vector  = @(Bitmap) double(reshape(Bitmap,row*col,1));
 vector_image  = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
 vector_render = @(Vec) imshow(vector_image(Vec));

filenames = dir('*.bmp');
n = size(filenames,1)
for i = 1:n
  Image_File = filenames(i).name;
  Face_Matrix = imread(Image_File);
  F(i,:) = image_vector(Face_Matrix);  % the i-th row of F is the i-th image
end

%-------------------------------

m = mean(F)';   % m is a vector containing the means of columns of F
vector_render(m)

image_vector  = @(Bitmap) double(reshape(Bitmap,row*col,1));
vector_image  = @(Vec) reshape( uint8( min(max(Vec,0),255) ), row, col);
vector_render = @(Vec) imshow(vector_image(Vec));

filenames = dir('*.bmp');
[row,col] = size(imread(filenames(1).name));
  %% row = 64
  %% col = 64

p = row*col;
n = size(filenames,1);
F = zeros(n,p);

for i = 1:n
  Image_File = filenames(i).name;
  Face_Matrix = imread(Image_File);
  F(i,:) = image_vector(Face_Matrix);  % the i-th row of F is the i-th image
end

M = ones(n,1) * mean(F);  %  rows of M = n replications of (the column means of F)

X = (F - M);

k = 30;                             %  arbitrarily choose k=30
[U_k,S_k,V_k] = svds( cov(X), k );  %  k-th order approximation to cov(X)

sigma = diag(S_k);

Eigenfaces = V_k;      % Eigenfaces = principal components of X = principal components of F

matrix_image = @(A) uint8( round( (A-min(A))/(max(A)-min(A)) * 255 ) )

figure
subplot(2,3,1)
scree_plot( sigma, 0.01 )
subplot(2,3,2)
vector_render( matrix_image(Eigenfaces(:,1)) )
xlabel('first Eigenface')
subplot(2,3,3)
vector_render( matrix_image(Eigenfaces(:,2)) )
xlabel('second Eigenface')
subplot(2,3,4)
vector_render( matrix_image(Eigenfaces(:,3)) )
xlabel('third Eigenface')
subplot(2,3,5)
vector_render( matrix_image(Eigenfaces(:,4)) )
xlabel('fourth Eigenface')
subplot(2,3,6)
vector_render( matrix_image(Eigenfaces(:,5)) )
xlabel('fifth Eigenface')

%-------------------------------

m = mean(F)';
f = image_vector(imread('face000.bmp'));
x = f - m;
c = V_k' * x;

factors = [1 2 4 6];
nfactors = max(size(factors));
figure
for i = 1:nfactors
  factor = factors(i);
  subplot(1,nfactors,i)
  cnew = c;
  cnew(4) = c(4) * factor;   % perturb the 4th coefficient by multiplicative factor
  vector_render( m + V_k * cnew );
  xlabel(sprintf('factor = %d', factor))
  if i*2==nfactors
     title('image with 4th Eigenface coefficient multiplied by a constant factor')
  end
end

