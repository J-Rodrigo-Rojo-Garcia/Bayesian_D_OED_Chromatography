function ip = interp_NB_vect(z,y,Nd,M)

	% Reescaling
	y = (y - z.lbnd)./(z.ubnd - z.lbnd);
	
	% Allocate
	ip = zeros(M,Nd);

	for k = z.nfrom:z.n
    	for ii = 1:Nd
	    	ip(:,ii) = ip(:,ii) + interp_NBO(z.d,z.vals{ii,k+1},y,z.levelseq{k+1},M,Nd);
		end
	end

end
