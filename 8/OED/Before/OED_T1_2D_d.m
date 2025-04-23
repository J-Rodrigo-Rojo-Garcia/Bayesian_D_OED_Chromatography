%%% Parameters collocation %%%

function [D1,D2,U,Smolyak] = OED_T1_2D_d(N_th,Nd,Deg_p,l,par_w,par_OED,Sigma,hyper,type,Lambda)
	
	%%% Surrogated %%%
	% Coefficients %
	[alpha,Nw,Cw,Cw_d,a,FitInfo,Dim_p,cond_Phi] = coefficients_ODE_d(N_th,Nd,Deg_p,l,par_w,par_OED,Sigma,hyper,type,Lambda);
		
	% Function
	SG_eval = surrogated_eval_type(type);
	
	%%% Auxiliar constants for density %%%
	% Constant for surrogated method
	Deg_p_1 = Deg_p + 1;
    N_th_1 = N_th + 1;
	
	% Auxiliar constants
	cons.C = log(par_OED.N_in);
	cons.C1 = -0.5/(Sigma*Sigma);
	cons.Cov = Sigma*Sigma*eye(Nd);
	
	% Parameters in loop
	N_in = par_OED.N_in; N_out = par_OED.N_out;	

	%%% Utility function %%%
	util = @(d) Utility_T1_d(SG_eval,a,Dim_p,Deg_p_1,alpha,par_w,par_OED,...
	d,Nd,Nw,N_th,N_th_1,Cw,Cw_d,cons,N_in,N_out,type);
	
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
			"[ii,jj] = "
			[ii,jj]
			d = [D1(ii,jj),D2(ii,jj)];
			U(ii,jj) = util(d);
			"U = "
			U
		end		
	end	
	T = toc

	%%% Smolyaks %%%
	Smolyak.alpha = alpha;
	Smolyak.Nw = Nw;
	Smolyak.Cw = Cw;
	Smolyak.Cw_d = Cw_d;
	Smolyak.a = a;
	Smolyak.Dim_p = Dim_p;
	Smolyak.Deg_p = Deg_p;
	Smolyak.l = l;
	Smolyak.par_w = par_w;
	Smolyak.par_OED = par_OED;
	Smolyak.N_th = N_th;

end

