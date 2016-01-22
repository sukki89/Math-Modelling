function [ ] = sheer( a,t )
  b = t * a;
  plot(a(1,:),a(2,:));
  hold on;
  plot(b(1,:),b(2,:));
  hold off;
  axis equal;
end

