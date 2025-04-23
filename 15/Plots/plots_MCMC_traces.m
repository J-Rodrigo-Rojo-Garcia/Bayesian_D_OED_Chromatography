function plots_MCMC_traces(N_th,chain,dire,Type,lbnd,ubnd,R)

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

    p_lab = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',...
    'Q','R','S','T','U','V','W','X','Y','Z'};
    
    % Traces
    fig = figure('visible','off');
    title('Trace')
    for k = 1:N_th	
    	subplot(N_th,1,k)
    	plot(chain(:,k),'b.-')
    	ylabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
        if (k == 1)
			p = join(['Trace ',Type, '. Point ',p_lab(R)]);
            title(p)
        end
    end
    xlabel('N','Interpreter','tex') % "latex" in Matlab
    file_name = join([dire,'trace.png']);
    saveas(fig,file_name)
    close(fig)

end
