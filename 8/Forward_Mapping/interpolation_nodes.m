function cI = interpolation_nodes(t_d,t,c,In,Nt_d,Nc)
  
	% Interpolation
	cI = zeros(Nt_d,Nc);
	for k = 1:Nt_d  
		for l = 1:Nc
			cI(k,l) = newton_interpolation(t_d(k),t(In(k,:)),c(In(k,:),l));
		end
	end

end
