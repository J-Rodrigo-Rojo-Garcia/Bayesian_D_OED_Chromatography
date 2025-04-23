%%% Determinant %%%

% Nd = Dimension of data

function det_I_Cov_f = det_I_Cov_T2(N_th,Ns_th,lbnd,ubnd,N_OED,Nd,d,Sigma2,hyper,Theta,N_TH)


	% 1) Sampling uncertainty parameters
	theta = randsample(N_TH,Ns_th);
	theta = Theta(theta,:);

	% 2) Simulation
	G = zeros(Nd,Ns_th);
	parfor k = 1:Ns_th
		% Forward Mapping
		G(:,k) = forward_mapping_dat_OED(theta(k,:),[1,d],hyper); 	
	end
	G_mean = mean(G,2);
	G = (G - G_mean);
	
	% 3) Covariances
	cons = 1.0/(Sigma2*(Ns_th - 1));
	A = zeros(Nd,Nd);
	parfor k = 1:Ns_th
		% Forward Mapping
		A = A + cons*G(:,k)*G(:,k)'; 	
	end

	% 4) Determinant
	det_I_Cov_f = det(eye(Nd) + A);	
	    
end

