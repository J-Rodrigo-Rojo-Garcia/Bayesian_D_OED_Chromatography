%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function U = Weights_T2(,x,y)

	%%% Surrogated model %%%

	% 1) Training
	G = training(aff_t_Z_X,Z,par_w,d,hyper,Nd,Nw,N_th);
	% 2) Coefficients
	a = coefficients_ls(Phi_T_Phi,Phi,G);
	
	% 3) Surrogated forward mapping
	SG = @(theta) S_FM(a,alpha,Deg_p_1,Dim_p,N_th,theta,par_w,Cw);
	
	%%% Auxiliar constants %%%
	C = cons.C;	C1 = cons.C1; Cov = cons.Cov;	
	
	% Utility function
	U = 0;

	% Prior sampling
	theta_pr = prior_sample_OED(aff_t_Z_X,N_in,N_th,par_w,type);

	% Forward Mapping (Samples)	
	G = zeros(Nd,N_in);	Y = G;
	parfor ii = 1:N_in
		G(:,ii) = SG(theta_pr(ii,:));
		Y(:,ii) = transpose(mvnrnd(G(:,ii),Cov,1)); 
	end
	
	% Sampling
    for ii = 1:N_out	
	
		%%% Step 2 - Sampling from conditional	p(y|theta = theta_i,d) %%%
		R = exp(C1*sum((Y(:,ii) - G).^2));

		% Sampling normal
%		y_i = transpose(mvnrnd(G(:,ii),Cov,1));

		%%% Step 3 - Estimation of p(y_i|d)	%%%
%		p_y_d = 0;
%		R = zeros(N_in,1);
%		for jj = 1:N_in
%			R(jj) = exp(C1*sum((y_i-G(:,jj)).^2));
%		end

		% Sort in ascending order (Accurate sum)
		R = sort(R);
%		for jj = 1:N_in
			% Evaluation of density function
%			p_y_d = p_y_d + R(jj);
%		end
		p_y_d = sum(R);

		%%% Step 4 - Utility average %%%
%		U = U + (C1*sum((y_i-G(:,ii)).^2) - log(p_y_d) + C)/N_out;
		U = U + (C1*sum((Y(:,ii)-G(:,ii)).^2) - log(p_y_d) + C)/N_out;
	end		
	    
end

