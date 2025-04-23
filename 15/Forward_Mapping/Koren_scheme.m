function c = Koren_scheme(tao_inj,Qs,b,c_Feed,Ntp,F,Nc,Ny,dy,tao,d_tao,N_tao,eta)

    %%%%%%%%%%% Koren Scheme %%%%%%%%%%%

	%%% Auxiliar constants %%%
	
	%For RK4
	c_RK4_1 = 0.5*d_tao; 
	c_RK4_2 = d_tao/6.0;
	
    % For PDE
	C_PDE_1 = -1.0/dy;
	C_PDE_2 = 0.5/(Ntp*dy*dy);	
	aF = F*Qs*b;

	%%% Inverse action of Jacobian Matrix %%%
	Jac_q_c_1 = Apply_inverse_Jac_isotherms(aF,b,Nc);

	%%% Boundary condition %%%
	c = zeros(N_tao,Nc);
	
	% Look for the time of injection
	N_inj = round(tao_inj/d_tao);
	
	% Substitute with the injection
	for k = 1:Nc
		c(2:N_inj,k) = c_Feed;%c_Feed(k);
	end
    
    %%% Forward Mapping %%%
	
	% Flux
	fj12 = zeros(Ny+1,Nc);	

    % Spatial discretization    
	G = @(c0,tk,ck) G_function_dispersion(c0,tk,ck,eta,Jac_q_c_1,C_PDE_1,C_PDE_2,fj12);

	% Previous step
	ck_1 = zeros(Ny,Nc);	% It begins with the initial condition in the ODE

	% ODE solution
	for k = 2:N_tao
		
		% Trapezoidal step	
		ck = RK4_step(G,c_RK4_1,c_RK4_2,c(k,:),tao(k-1),ck_1,tao(k),d_tao);
		
		% Save the last layer
		c(k,:) = ck(end,:);
		
		% Update
		ck_1 = ck;
		
	end	
	
end
