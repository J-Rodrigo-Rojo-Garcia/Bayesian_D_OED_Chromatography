function U = Utility_Tr_Ev(d,FM,M,N_th,Nd,Theta_Pr,Noise,depth,Grids)

	% Parameters
	type_S = Grids.type_S;
	Sparse = Grids.Sparse;
	lbnd = Grids.lbnd(1:N_th);
	ubnd = Grids.ubnd(1:N_th);
	Grid = 'on';

	% Forward Mapping depending of "theta" and "d" ---> "theta"
	F_M = @(theta) FM(theta,d);

	% Parallel training
	Xk = Grids.X{depth};
	N = length(Xk);
	Fk = Parallel_Evaluations(F_M,Xk,N,Nd);

	% Training
	fun = @(x) Wrapp_Function(x,Xk,Fk,Nd);
	z = training_process_vect(fun,N_th,Nd,lbnd,ubnd,depth,type_S,Sparse,Grid);	
	SFM = @(theta) interp_CC_vect(z,theta,Nd,1); 
	
	% Parameters for utility function
	Prec = (1.0/Noise.Sigma2);
	Sigma = Noise.Sigma;
	log_prior = log(1.0/prod(ubnd-lbnd));
	
	% Utility function evaluation
	U = Utility_E2_d(SFM,M,N_th,Prec,Sigma,Theta_Pr,log_prior,Nd);
	
end
