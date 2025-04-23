%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Nd = Dimension of data

function theta_post = inv_prob_sample(FM,N_th,data,Nd,Sigma2,M,lbnd,ubnd)
   
    %%% Model for MCMC %%%
    	
    % -2*Log(likelihood)
    model.ssfun = @(theta,data) sum((FM(theta)-data).^2);
        
    % -2*Log(prior)
    model.priorfun = @(theta,pri_mu,pri_sig) 0;
	        
    % Initial error variance
    model.sigma2 = Sigma2;

	% Number of observations
	model.N = Nd;
	
    %%% Params theta structure %%%
    params = parameter_structure(N_th,lbnd,ubnd);
   
    %%% Options simulation %%%
    options.nsimu = M;     				% Number of simulations
    options.qcov = 0.01*eye(N_th);      % Proposal covariance
%	options.qcov = 0.05*diag((ubnd - lbnd).^2);
    options.method = 'dram';
    options.adaptint = 1000;          	% Interval for adaptation, if 'dram' or 'am' used
    options.updatesigma = 0;      		% Update error variance
    
    %%% MCMC run %%%
	[res,theta_post,s2chain,sschain] = mcmcrun(model,data,params,options);
    
end

