%%% Parameters collocation %%%

function u = Utility_parallel(fun,M,N_th,d,Prec,Sigma,Theta_prior,log_prior,Nd)
	
	%%% Sample %%%
	U = zeros(M,1);
	
	% Subdivision %
	R = 5000;
	
	%%% FM sample %%%
	FM = zeros(M,Nd);
	parfor k = 1:M
		% Sample
		theta_k = Theta_prior(k,:);
		% Surrogated model
		temp = fun(theta_k,d);
		FM(k,:) = temp;
	end

	%%%% Utility %%%%
	parfor k = 1:M

		% Sampling from likelihood
		y = FM(k,:);
		
		% Sampling from likelihood
		yk = y + Sigma*randn(1,Nd);
		
		% MSE
		rk = y-yk;
		r = -0.5*sum(rk.^2)*Prec;
		
		% Marginal
		M2 = floor(M/R);
		ul = 0;	
		for l = 1:M2
			
			% Indexes
			I1 = 1 + R*(l-1);
			I2 = R*l;
			temp2 = FM(I1:I2,:);
			
			% Sampling from likelihood
			ul = ul + sum(exp(-0.5*sum((temp2 - yk).^2,2)*Prec));	

		end
	
		% Indexes
		I1 = 1 + R*M2;
		temp2 = FM(I1:M,:);
		
		% Sampling from likelihood
		ul = ul + sum(exp(-0.5*sum((temp2 - yk).^2,2)*Prec)); 
		
		% Utility function
		p_y_d = log(ul);
		U(k) = (r - p_y_d)/M;

	end
	u = sum(U) + log(M);
	    
end


