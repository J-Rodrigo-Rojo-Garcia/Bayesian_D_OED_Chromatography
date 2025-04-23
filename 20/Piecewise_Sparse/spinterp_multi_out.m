function ip = spinterp_multi_out(z,X,Nd)

	% Allocate
	ip = zeros(Nd,1);
	
	% Interpolating for any components
	for k = 1:Nd
		z.selectOutput = k;
		ip(k) = spinterp(z, X);
	end

end

