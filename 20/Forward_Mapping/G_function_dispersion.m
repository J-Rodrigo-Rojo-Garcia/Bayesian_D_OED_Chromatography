function G = G_function_dispersion(c0,tk,c,eta,Jac_q_c_1,C_PDE_1,C_PDE_2,fj12)

    %%%%%%%%%%% Spatial discretization %%%%%%%%%%%

	% Flux
	flu = flux(c,c0,eta,fj12);
	G = flu(2:end,:) - flu(1:end-1,:); 

	% Difussion term
	G = C_PDE_1*G + C_PDE_2*difussion_c(c);

	% Apply Jacobian Matrix
	G = Jac_q_c_1(c,G);

end
