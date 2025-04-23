function ip = interp_CC_vect(z,y,Nd,M)
	
	% Reescaling
	y = (y - z.lbnd)./(z.ubnd - z.lbnd);

	% Interp
	ip = interp_CC_sparse_vect(z.d,z.vals,y,z.indices,M,Nd);

end
