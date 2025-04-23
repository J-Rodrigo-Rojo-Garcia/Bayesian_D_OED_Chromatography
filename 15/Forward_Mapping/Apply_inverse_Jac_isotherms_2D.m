function J_1_c = Apply_inverse_Jac_isotherms_2D(aF,b,c,Gc)

    %%% Blocks %%%
    den2_1 = 1./((1.0 + b(1)*c(:,1) + b(2)*c(:,2)).^2);
    A = 1 + aF(1)*(1 + b(2)*c(:,2)).*den2_1;
    B = -aF(1)*b(2)*c(:,1).*den2_1;    
    C = -aF(2)*b(1)*c(:,2).*den2_1;    
    D = 1 + aF(2)*(1 + b(1)*c(:,1)).*den2_1;
 
 	%%% Schur Complement solution of linear system %%%
 	J_1_c = c;
 	
 	% Step 1
 	J_1_c(:,2) = (Gc(:,2) - C.*Gc(:,1)./A)./(D - C.*B./A);

	% Step 2
 	J_1_c(:,1) = (Gc(:,1) - B.*J_1_c(:,2))./A;
 
end
