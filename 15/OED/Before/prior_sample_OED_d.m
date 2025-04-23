function Theta = prior_sample_OED_d(N_in,N_th,par_w,par_OED,type)

	% Allocate
	Theta = zeros(N_in,N_th + par_OED.N_OED);
	
	% Function for affine transformation
	aff_t_Z_X = affine_transformations_Z_X(type);

	% Uniform distribution (Legendre Polynomials)
	if (type == 'GL') 
		
		% Sampling from uniform
		Theta(:,1:N_th) = 2*rand(N_in,N_th) - 1.0;

	% Normal distribution (Hermite Polynomials)
	elseif (type == 'GH') 
	
		% Sampling from normal
		Theta(:,1:N_th) = randn(N_in,N_th);
		
	else 
	
    	'Error, invalid distribution'
    	return
    	
    end		
	
	% Affine transformations%
	
	% For uncertainty parameters
	Theta(:,1:N_th) = aff_t_Z_X(Theta(:,1:N_th),par_w,N_th);
	% For design parameters
	Theta(:,1+N_th:end) = legendre_affine_transformation_Z_X(Theta(:,1+N_th:end),par_OED,par_OED.N_OED);	
	
end

