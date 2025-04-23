function Lag = coef_lagrange_interp(t,t_d,In,Nt_d)

  % Coefficients
  Lag = zeros(Nt_d,3);
  
  % Nearest nodes
  for k = 1:Nt_d
    
    % Nearest neighbours
    t_n = t(In(k,:));
    
    % Lagrange coefficients

	% First step
    Lag(k,1) = (t_d(k) - t_n(2))*(t_d(k) - t_n(3));
    Lag(k,1) = Lag(k,1)/((t_n(1) - t_n(2))*(t_n(1) - t_n(3)));    
    
	% Second step
    Lag(k,2) = (t_d(k) - t_n(1))*(t_d(k) - t_n(3));
    Lag(k,2) = Lag(k,2)/((t_n(2) - t_n(1))*(t_n(2) - t_n(3)));    

	% Third step
    Lag(k,3) = (t_d(k) - t_n(1))*(t_d(k) - t_n(2));
    Lag(k,3) = Lag(k,3)/((t_n(3) - t_n(1))*(t_n(3) - t_n(2)));    
    
  end
    

end
