function plots_time_comp_piecewise(t_real,t_surrogated,depth,Nw,titles,name,dire)

	% X Axis
	dims = size(t_surrogated); 
	S = (1:dims(1))';

	% Legends
    leg = {};
    leg{1} = 'True'; 
    for k = 1:dims(2)
		leg{k+1} = join(['Depth = ', int2str(depth(k)),', Nw = ', int2str(Nw(k))]);	    
    end


	% Colors
	colo = {'r-','m-','c-','b-','g-'};

	% Plots
	fig = figure('visible','off');
    loglog(S,t_real,'k-')
    hold on
    for k = 1:dims(2)
    	loglog(S,t_surrogated(:,k),colo{k})
    	hold on
    end	
    hold off
    xlabel("Simulation",'Interpreter','tex') % "latex" in Matlab
    ylabel("t",'Interpreter','tex') % "latex" in Matlab
	title(titles)
	legend(leg,'Location','northeast')
	legend('Orientation','vertical')
	legend('boxoff')
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	filename = join([dire,name]);
	print(fig,filename,'-dpdf','-r0')
    close(fig)

end
