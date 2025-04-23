function c_k = newton_interpolation(t_k,t,c)
  
  % Weights
  L = [0;0;0];
  
  L(1) = (t_k - t(2))*(t_k - t(3));
  L(1) = L(1)/((t(1) - t(2))*(t(1) - t(3)));
  
  L(2) = (t_k - t(1))*(t_k - t(3));
  L(2) = L(2)/((t(2) - t(1))*(t(2) - t(3)));

  L(3) = (t_k - t(1))*(t_k - t(2));
  L(3) = L(3)/((t(3) - t(1))*(t(3) - t(2)));

  % Linear combination
  c_k = dot(L,c);
  
end
