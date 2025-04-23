function varargout = Forward_Mapping_Varargout(t_inj,Qs,b,c_Feed,U,Dapp,F,Nc,Nz,dz,t,dt,Nt,eta,t_d,In,Nt_d,Nd)

	% Koren Scheme
	c = Koren_scheme(t_inj,Qs,b,c_Feed,U,Dapp,F,Nc,Nz,dz,t,dt,Nt,eta);

	% Interpolation nodes
	cI = interpolation_nodes(t_d,t,c,In,Nt_d,Nc);
	
	% Vector column format
	cI = cI(:);	
	
	for k = 1:Nd
		varargout{k} = cI(k);
	end    

end
