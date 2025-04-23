%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function U = Utility_T1_d(SG_eval,a,Dim_p,Deg_p_1,alpha,par_w,par_OED,d,Nd,Nw,...
N_th,N_th_1,Cw,Cw_d,cons,N_in,N_out,type)

	% Surrogated forward mapping
	SG = @(theta) Surrogated_FM_d(SG_eval,a,alpha,Deg_p_1,Dim_p,...
	N_th,N_th_1,par_OED.N_OED,theta,d,par_w,par_OED,Cw,Cw_d);
	
	%%% Auxiliar constants %%%
	C1 = cons.C1; Cov = cons.Cov;	
	
	% Divide the problem
	R = 10^5;
	Nk = N_in/R;
	
	if (Nk < 1)
		Nm = N_in;
		Nk = 1;
	else
		Nm = R;
		Nk = ceil(Nk);
	end
	C = log(Nm*Nk);

	% Utility function
	U = 0;
	u = zeros(Nm,1);

	for k = 1:Nk
		"k = "
		k
		% Prior sampling
		theta_pr = prior_sample_OED_d(Nm,N_th,par_w,par_OED,type);

		% Forward Mapping (Samples)	
		G = zeros(Nd,N_in);	Y = G;
		parfor ii = 1:Nm
			G(:,ii) = SG(theta_pr(ii,1:N_th));
			Y(:,ii) = transpose(mvnrnd(G(:,ii),Cov,1)); 
		end
	
		% Sampling
    	parfor ii = 1:Nm	
	
			%%% Step 2 - Sampling from conditional	p(y|theta = theta_i,d) %%%
			R = exp(C1*sum((Y(:,ii) - G).^2));

			% Sort in ascending order (Accurate sum)
			R = sort(R);
			p_y_d = sum(R);

			%%% Step 4 - Utility average %%%
			u(ii) = (C1*sum((Y(:,ii)-G(:,ii)).^2) - log(p_y_d) + C)/N_out;
			
		end
		U = U + sum(u);
				
	end	    
end

