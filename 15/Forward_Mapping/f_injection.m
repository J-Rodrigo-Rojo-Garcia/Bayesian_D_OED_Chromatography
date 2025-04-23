function f_inj = f_injection(t,t_inj,U,c_Feed)

    % Ratio
    f_inj = 0.0*c_Feed;
    if (t <= t_inj)
        f_inj = c_Feed;
    end                  	

end
