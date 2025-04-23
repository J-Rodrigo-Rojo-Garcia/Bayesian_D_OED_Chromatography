function Jac_q_c = Jac_isotherms_2(aF,b,c,Nc,Nz,aux,I1,I2,Ids)

    %%% Langmuir model %%%
    
    % Denominator
	den_1 = 1.0./(1 + c*b);    
    den2_1 = den_1.*den_1;

	% Transform the solution in one vector
	Jac_q_c = aux;

	% Blocks	
	for ii = 1:Nc
		for jj = 1:Nc

			% Elements outside of the diagonal
			Jac_q_c(I1(ii):I2(ii),I1(jj):I2(jj)) = spdiags((-aF(ii)*b(jj))*c(:,ii).*den2_1,0,Nz,Nz);
		end	

		% Main diagonal
		Jac_q_c(I1(ii):I2(ii),I1(ii):I2(ii)) = Jac_q_c(I1(ii):I2(ii),I1(ii):I2(ii)) + ...
		spdiags(aF(ii)*den_1,0,Nz,Nz) + Ids;

	end
    
 
end
