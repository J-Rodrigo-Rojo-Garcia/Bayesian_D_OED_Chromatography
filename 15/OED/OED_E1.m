%%% Parameters collocation %%%

function [D1,D2,U] = OED_E1(fun,N_th,Nd,lbnd,ubnd,Sigma2,M,N_OED,Nx)
	
	%%% Likelihood %%%
	norm_par.Cov = Sigma2*eye(Nd);
	norm_par.Prec = (1.0/Sigma2)*eye(Nd);
	norm_par.cons = -log(det(norm_par.Cov)) - 0.5*Nd*log(2*pi);
	
	%%% Log prior %%%
	log_prior = log(1/prod(ubnd(1:N_th)-lbnd(1:N_th)));

	%%% Utility function %%%
	util = @(d) Utility_E1(fun,M,N_th,lbnd(1:N_th),ubnd(1:N_th),d,norm_par,log_prior);
	
	%%% Nodes for design %%%
	D = zeros(N_OED,Nx);
	for k = 1:N_OED
		D(k,:) = linspace(lbnd(k+N_th),ubnd(k+N_th),Nx);
    end
	[D1,D2] = meshgrid(D(1,:),D(2,:));
	
	%%% Evaluations %%%
	U = D1;
	for ii = 1:Nx
		for jj = 1:Nx
			d = [D1(ii,jj),D2(ii,jj)];
			U(ii,jj) = util(d);
		end		
	end	

end

