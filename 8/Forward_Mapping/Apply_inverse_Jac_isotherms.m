function Jac_q_c_1 = Apply_inverse_Jac_isotherms(aF,b,Nc)

    % Choose the case %
    if (Nc == 1)
    	Jac_q_c_1 = @(c,Gc) Apply_inverse_Jac_isotherms_1D(aF,b,c,Gc);
    else 
    	Jac_q_c_1 = @(c,Gc) Apply_inverse_Jac_isotherms_2D(aF,b,c,Gc);    	
    end
  
end
