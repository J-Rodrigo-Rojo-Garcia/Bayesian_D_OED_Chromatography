%%% Parameters collocation %%%

function u = Utility_E1(fun,M,N_th,lbnd,ubnd,d,norm_par,log_prior)

	%%% Sample %%%
	U = zeros(M,1);

	%%%% Utility %%%%
	parfor k = 1:M

		% Sample
		theta = lbnd + (ubnd - lbnd).*rand(1,N_th);
		
		% Surrogated model
		y = fun(theta,d);
		
		% Sampling from likelihood
		yk = mvnrnd(y,norm_par.Cov);
		
		% Square error
		r = y - yk;
		
		% Square error
		U(k) = r*(norm_par.Prec)*(r');
	end
	
	% Utility function
	u = (-0.5*sum(U) + norm_par.cons)/M;
	    
end

