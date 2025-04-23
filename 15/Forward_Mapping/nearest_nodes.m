function In = nearest_nodes(t,t_d)

  % Length of data
  N_d = length(t_d);
  
  % Nearest nodes
  In = zeros(N_d,3);
  
  for k = 1:N_d
    
    % Distance to each element in data
    dist = abs(t - t_d(k));
    % Sort
    [out,idx] = sort(dist);
    % Three nearest nodes
    In(k,:) = sort(idx(1:3));
    
  end
    

end
