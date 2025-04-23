%%% Parameters collocation %%%

function E = OED_E2(fun,N_th,Nd,lbnd,ubnd,Noise,M,N_OED,Theta_prior,d0,N_OED_T)
	
	%%% Likelihood %%%
	Prec = (1.0/Noise.Sigma2);
	Sigma = Noise.Sigma;
	
	%%% Log prior %%%
	log_prior = log(1/prod(ubnd(1:N_th)-lbnd(1:N_th)));

	%%% Utility function %%%
	util = @(d) Utility_E2_imp(fun,M,N_th,d,Prec,Sigma,Theta_prior,log_prior,Nd);
	
	%%% Nodes for design %%%
	E = zeros(N_OED_T,N_OED + 1);
	E(:,1:N_OED) = d0;

	%%% Evaluations %%%
	for k = 1:N_OED_T
		E(k,1 + N_OED) = util(d0(k,:));
	end

end

