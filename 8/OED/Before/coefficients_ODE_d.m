%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function [alpha,Nw,Cw,Cw_d,a,FitInfo,Dim_p,cond_Phi] = coefficients_ODE_d(N_th,Nd,Deg_p,l,par_w,par_OED,Sigma,hyper,type,Lambda)
	
	%%% Surrogated %%%
	% Smolyak nodes and weights %
	[alpha,Dim_p,Z,W,Nw,Cw,Cw_d,C_dens] = weights_coef_d(N_th,Deg_p,l,par_w,type,par_OED.N_OED);

	% Coefficients %
	[a,FitInfo,cond_Phi] = coefficients_ls_FM_d(type,Z,par_w,par_OED,hyper,Nd,Nw,Dim_p,Deg_p + 1,...
	N_th,Cw,Cw_d,alpha,Lambda);
		
end

