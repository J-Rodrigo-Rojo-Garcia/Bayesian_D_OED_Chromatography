function plots_error(E_abs,E_rel,depths,dire)

	% Colors
	colors = {'ro','gs','b*','m-','g-','c-'};

	% Size of the vector
	[M,Depth_max] = size(E_abs);

	% Legends
	leg0 = {};
	for k = 1:Depth_max
		legk = join(['Depth ',int2str(depths(k))]);
		leg0{k} = legk;
	end

	% X axis
	Ind = (1:M)';

	% Plots 
	fig = figure('Visible','off');
	p = 'Absolute error';
	for k = 1:Depth_max
		semilogy(Ind,E_abs(:,k),colors{k})
		hold on
	end	
	hold off
	xlabel('Experiment','Interpreter','tex') % "latex" in Matlab
	ylabel('err','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'abs_error.pdf']);
	title(p)
	legend(leg0)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

	% Plots 
	fig = figure('Visible','off');
	p = 'Relative error';
	for k = 1:Depth_max
		semilogy(Ind,E_rel(:,k),colors{k})
		hold on
	end
	hold off
	xlabel('Experiment','Interpreter','tex') % "latex" in Matlab
	ylabel('err','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'rel_error.pdf']);
	title(p)
	legend(leg0)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
