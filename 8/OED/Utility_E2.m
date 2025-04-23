%%% Parameters collocation %%%

function u = Utility_E2(fun,M,N_th,lbnd,ubnd,d,norm_par,Theta_prior,log_prior,Nd)

	%%% Sample %%%
	U = zeros(M,1);
	
	%%% FM sample %%%
	FM = zeros(M,Nd);
	parfor k = 1:M
		% Sample
		theta_k = Theta_prior(k,:);
		
		% Surrogated model
		FM(k,:) = fun(theta_k,d);
	end

	%%%% Utility %%%%
	r = 0;
	parfor k = 1:M

		% Sampling from likelihood
		y = FM(k,:);

		% Sampling from likelihood
		yk = mvnrnd(y,norm_par.Cov);

		% MSE
		rk = y-yk;
		r = -0.5*sum(rk.^2)*norm_par.Prec;
		
		% Acumulator
		ul = 0;	
		for l = 1:M
			
			% Sampling from likelihood
			yl = FM(l,:);
		
			% Square error
			rl = yl - yk;
			
			% Importance sampling
			ul = ul + exp(-0.5*sum(rl.^2)*norm_par.Prec);
		
		end
		
		% Utility function
		p_y_d = log(ul);
		U(k) = (r - p_y_d)/M;
	end
	u = sum(U) + log(M);
	    
end

