%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function [D1,D2,U] = OED_T1_2D(N_th,Nd,Deg_p,l,par_w,par_OED,Sigma,hyper,type)
	
	%%% Smolyak nodes and weights %%%
	[alpha,Dim_p,nodes,weights,Nw,Cw,C_dens] = weights_coef(N_th,Deg_p,l,par_w,type);	

	%%% Surrogated Forward Mapping (Least squares approach) %%%

	% 1) Type and auxiliar functions
	[aff_t_Z_X,PB] = auxiliar_functions(type);
	
	% 2) Normal matrix 
	[Phi,Phi_T_Phi] = normal_matrix(PB,Dim_p,Deg_p+1,N_th,nodes,Nw,Cw,alpha);
	
	% 3) Surrogated model %%%
	S_FM = surrogated_type(type);

	%%% Auxiliar constants for density %%%
	% Constant for surrogated method
	Deg_p_1 = Deg_p + 1;
	
	% Auxiliar constants
	cons.C = log(par_OED.N_in);
	cons.C1 = -0.5/(Sigma*Sigma);
	cons.Cov = Sigma*Sigma*eye(Nd);
	
	% Parameters in loop
	N_in = par_OED.N_in; N_out = par_OED.N_out;	

	%%% Utility function %%%
	util = @(d) Utility_T1(aff_t_Z_X,S_FM,Phi_T_Phi,Phi,Dim_p,...
Deg_p_1,alpha,nodes,par_w,d,hyper,Nd,Nw,N_th,Cw,cons,N_in,N_out,type);
	
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
			"i,j = "
			[ii,jj]
			d = [1;D1(ii,jj);D2(ii,jj)];
			"d = "
			d
			U(ii,jj) = util(d);
			"U(d) = "
			U(ii,jj)
		end		
	end	
	T = toc
	
end

