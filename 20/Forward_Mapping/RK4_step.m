function ck = RK4_step(G,c_RK4_1,c_RK4_2,c0,tk_1,ck_1,tk,dt)

	% Stage 1
	K1 = G(c0,tk,ck_1);
	
	% Stage 2
	K2 = G(c0,tk_1 + c_RK4_1,ck_1 + c_RK4_1*K1);	

	% Stage 3
	K3 = G(c0,tk_1 + c_RK4_1,ck_1 + c_RK4_1*K2);		

	% Stage 4
	K4 = G(c0,tk,ck_1 + dt*K3);		
	
	% Final Step
	ck = ck_1 + c_RK4_2*(K1 + 2.0*K2 + 2.0*K3 + K4);

end
