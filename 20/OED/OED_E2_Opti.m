%%% Parameters collocation %%%

function [d_opt,fval,d_history] = OED_E2_Opti(fun,N_th,Nd,lbnd,ubnd,Noise,M,d_par)
	
	%%% Sample of the prior %%%
	Theta_prior = rand(M,N_th);
	for k = 1:N_th
		Theta_prior(:,k) = lbnd(k) + (ubnd(k) - lbnd(k))*Theta_prior(:,k);
	end 
	
	%%% Likelihood %%%
	Prec = (1.0/Noise.Sigma2);%*eye(Nd);
	Sigma = Noise.Sigma;
%	norm_par.cons = -log(det(norm_par.Cov)) - 0.5*Nd*log(2*pi);
	
	%%% Log prior %%%
	log_prior = log(1/prod(ubnd(1:N_th)-lbnd(1:N_th)));

	%%% Utility function %%%
	util = @(d) -Utility_E2_imp(fun,M,N_th,d,Prec,Sigma,Theta_prior,log_prior,Nd);
	
	%%% Evaluations %%%
%	options = optimset('Display','off','PlotFcns',@optimplotfval,'TolFun',0.001,'MaxIter',30);
%	[d_opt,fval,d_history] = fminsearchbnd(util,d_par.d0,d_par.dmin,d_par.dmax);
	[d_opt,fval,d_history] = my_problem(util,d_par.d0,d_par.dmin,d_par.dmax);

end

