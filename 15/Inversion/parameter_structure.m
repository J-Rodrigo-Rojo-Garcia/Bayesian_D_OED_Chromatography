function params = parameter_structure(N_th,lbnd,ubnd)

	% Initial value
	init_val = lbnd + (ubnd - lbnd).*rand(size(lbnd));

	% Mean value prior
	pri_mu = 0.5*(lbnd + ubnd);

	% Variance prior
	pri_sig = sqrt(((ubnd - lbnd).^2)/12.0);
	
	% Parameters	
	for k=1:N_th
		% Structure
    	params{k} = {sprintf('\\theta_{%d}',k),init_val(k),lbnd(k),ubnd(k),pri_mu(k), pri_sig(k)}; 
	end
	
end

