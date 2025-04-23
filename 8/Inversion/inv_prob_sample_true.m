%%% Parameters collocation %%%

% N_th = Dimension of parameter space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function theta_post = inv_prob_sample_true(N_th,data,Nd,lbnd,ubnd,d,Sigma2,hyper,M)
   
    %%% Model for MCMC %%%
    
	% Posterior
	FM = @(theta) forward_mapping_dat_OED(theta,[1,d],hyper);
    
    % -2*Log(likelihood)
    model.ssfun = @(theta,data) sum((FM(theta)-data).^2);
        
    % -2*Log(prior)
    neg_2_log_meas = 0; 
    
    model.priorfun = @(theta,pri_mu,pri_sig) neg_2_log_meas;
	        
    % Initial error variance
    model.sigma2 = Sigma2;

	% Number of observations
	model.N = Nd;
	
    %%% Params theta structure %%%
    params = parameter_structure_PI(N_th,lbnd,ubnd);
    
    %%% Options simulation %%%
    options.nsimu = M;     				% Number of simulations
%    options.qcov = 0.01*eye(N_th);      % Proposal covariance
	options.qcov = 0.05*diag((ubnd - lbnd).^2);
    options.method = 'dram';
    options.adaptint = 1000;          	% Interval for adaptation, if 'dram' or 'am' used
    options.updatesigma = 0;      		% Update error variance
    
    %%% MCMC run %%%
	[res,theta_post,s2chain,sschain] = mcmcrun(model,data,params,options);
    
end

