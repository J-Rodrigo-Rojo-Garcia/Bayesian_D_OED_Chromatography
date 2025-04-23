% This function connects MATLAB parameters with a Fortran script

function my_save_mcmc(filename,theta_post)

	save(filename,'theta_post','-ascii')
	
end



