function cI = Forward_Mapping(tao_inj,Qs,b,c_Feed,Ntp,F,Nc,Ny,dy,tao,d_tao,N_tao,eta,tao_d,In,Nt_d)

	% Koren Scheme
	c = Koren_scheme(tao_inj,Qs,b,c_Feed,Ntp,F,Nc,Ny,dy,tao,d_tao,N_tao,eta);

	% Interpolation nodes
	cI = interpolation_nodes(tao_d,tao,c,In,Nt_d,Nc);
	
	% Vector column format
%	cI = cI(:)';
	cI = cI(:);		    		    
	
end
