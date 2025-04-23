function J_1_c = Apply_inverse_Jac_isotherms_1D(aF,b,c,Gc)

    %%% Langmuir model %%%
    J_1_c = 1 + (aF./((1.0 + b*c).^2));
    J_1_c = Gc./J_1_c;
 
end
