function plots_time(Time,dire)

	% Colors
	colors = {'r-','b-'};

	% Vector
	N = length(Time);
	Ind = (1:N)';
	
	% Legends
	leg0 = {'Fortran 95','Matlab'};

	% Plots 
	fig = figure('Visible','off');
	p = 'Time comparison';
	plot(Ind,Time(:,1),colors{1})
	hold on
	plot(Ind,Time(:,2),colors{2})
	hold off
	xlabel('Experiment','Interpreter','tex') % "latex" in Matlab
	ylabel('t [s]','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'time_comparison.pdf']);
	title(p)
	legend(leg0)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
