function scree_plot( sigma, percent )
   plot( sigma, 'b.' )
   hold on
   k = max(size(sigma));
   plot( [0 k], [percent percent] * sum(sigma), 'r-' )
   title('a "scree plot":  singular values of the face matrix X')
   xlabel('the red line is 1 percent of the total of all singular values')
   hold off
end
