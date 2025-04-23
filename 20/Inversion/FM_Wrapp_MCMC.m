% This function connects MATLAB parameters with a Fortran script

function F = FM_Wrapp_MCMC(theta,d,execution,filename_th,filename_d,filename_res)

	% 1) Save the parameters
	Theta = theta(:);
	save(filename_th,'Theta','-ascii')
	save(filename_d,'d','-ascii')

	% 2) Run the executable
	system(execution);
	
	% 3) Read the results
	F = load(filename_res);
	
end



