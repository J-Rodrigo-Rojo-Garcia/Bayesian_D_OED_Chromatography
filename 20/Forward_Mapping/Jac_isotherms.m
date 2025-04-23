function Jac_q_c = Jac_isotherms(aF,b,c,Nc,aux)

    %%% Langmuir model %%%
    
    % Denominator
	den = 1 + dot(b,c);    
    den2 = den*den;

	% Elements outside of the diagonal    
    Jac_q_c = aux.*c;
    for l = 1:Nc
        % Main diagonal
        Jac_q_c(l,l) = aF(l)*(den - b(l)*c(l)) + den2;
%        Jac_q_c(l,l) = Jac_q_c(l,l) + a(l)*den + den2;        
    end
    
    % Final
    Jac_q_c = Jac_q_c/den2;
 
end
