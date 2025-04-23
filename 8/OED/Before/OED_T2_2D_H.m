%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function [D1,D2,U] = OED_T2_2D_H(N_th,par_OED,lbnd,ubnd,Nd,Sigma2,hyper,Theta)
	
    %%% Model for utility %%%
	N_TH = length(Theta);
	
    
	% Posterior
	util = @(d) det_I_Cov_T2(N_th,par_OED.Ns_th,lbnd,ubnd,par_OED.N_OED,Nd,d,Sigma2,hyper,Theta,N_TH);

	%%% Nodes for design %%%
	D = zeros(par_OED.N_OED,par_OED.Nx);
	for k = 1:par_OED.N_OED
		D(k,:) = linspace(par_OED.lbnd(k),par_OED.ubnd(k),par_OED.Nx);
    end
	[D1,D2] = meshgrid(D(1,:),D(2,:));
	
	%%% Evaluations %%%
	U = D1;
	tic
	for ii = 1:par_OED.Nx
		for jj = 1:par_OED.Nx
			"(ii,jj)"
			[ii,jj]
			d = [D1(ii,jj),D2(ii,jj)];
			U(ii,jj) = util(d);
			"U = "
			U(ii,jj)
		end		
	end	
	T = toc
	
end

