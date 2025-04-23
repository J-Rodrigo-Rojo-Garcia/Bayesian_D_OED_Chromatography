function phi_K = limiting_Koren(r)

    % Ratio
    phi_K = min((1.0 + 2.0*r)/3.0,2.0);
    phi_K = min(2.0*r,phi_K);
    phi_K = max(0.0,phi_K);

end
