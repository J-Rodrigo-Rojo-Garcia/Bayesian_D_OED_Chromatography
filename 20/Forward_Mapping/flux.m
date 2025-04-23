function f_j_1_2 = flux(c,c0,eta,fj12)

    %%% Initial Memory %%%
%    f_j_1_2 = zeros(Nz+1,Nc); %fj12;
    f_j_1_2 = fj12;    

    %%% Left side %%%
    f_j_1_2(1,:) = c0;					% j = 0		Boundary condition
    f_j_1_2(2,:) = c(1,:);	    		% j = 1
     
    %%% Interior %%%
%    f_j_1_2(3:end-1,:) = flux_ratio(U,c,eta);
    f_j_1_2(3:end-1,:) = ((c(3:end,:) - c(2:end-1,:)) + eta);
    f_j_1_2(3:end-1,:) = f_j_1_2(3:end-1,:)./((c(2:end-1,:) - c(1:end-2,:)) + eta);
    
    % Limiting Koren function (Phi_{j+1/2})
    f_j_1_2(3:end-1,:) = limiting_Koren(f_j_1_2(3:end-1,:));
    
    % Flux (f_{j+1/2})
    f_j_1_2(3:end-1,:) = c(2:end-1,:) + 0.5*f_j_1_2(3:end-1,:).*(c(3:end,:) - c(2:end-1,:));
              
    %%% Right side %%%
    f_j_1_2(end,:) = c(end,:);
    
    %%% Multiply by velocity %%%
    f_j_1_2 = f_j_1_2;

end
