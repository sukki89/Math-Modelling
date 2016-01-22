function X_k = kthOrderApproximation(X, k)
   [U,S,V] = svds(X, k);
   U_k = U(:, 1:k);
   V_k = V(:, 1:k);
   S_k = S(1:k, 1:k);
   X_k = U_k * S_k * V_k';
end
