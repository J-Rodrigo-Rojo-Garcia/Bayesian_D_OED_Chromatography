function Theta = prior_sample_OED(aff_t_Z_X,N_in,N_th,par_w,type)

	% Uniform distribution (Legendre Polynomials)
	if (type == 'GL') 
		
		% Sampling from uniform
		Theta = 2*rand(N_in,N_th) - 1.0;

	% Normal distribution (Hermite Polynomials)
	elseif (type == 'GH') 
	
		% Sampling from normal
		Theta = randn(N_in,N_th);
		
	else 
	
    	'Error, invalid distribution'
    	return
    	
    end		
	
	% Affine transformation
	Theta = aff_t_Z_X(Theta,par_w,N_th);
	
end

