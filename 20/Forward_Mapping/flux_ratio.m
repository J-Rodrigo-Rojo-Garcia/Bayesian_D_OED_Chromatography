function r_1_2 = flux_ratio(U,c,eta)

    % Ratio
    r_1_2 = U*(c(3:end,:) - c(2:end-1,:)) + eta;
    r_1_2 = r_1_2./ (U*(c(2:end-1,:) - c(1:end-2,:)) + eta);	

end
