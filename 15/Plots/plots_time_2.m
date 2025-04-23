function plots_time_2(Time,Time_s,dire)

	% Size
	[M,Depth_max] = size(Time_s);
	Ind = (1:M)';

	% Colors
	colors = {'r-','g-','b-','m-'};

	% Legends
	leg0 = {'True','Depth 3','Depth 4','Depth 5','Depth 6'};

	% Plots 
	fig = figure('Visible','off');
	p = 'Time comparison';	
	semilogy(Ind,Time,'k-')
	hold on
	for k = 1:4
		semilogy(Ind,Time_s(:,k+2),colors{k})
		hold on
	end
	hold off	
	xlabel('Experiment','Interpreter','tex') % "latex" in Matlab
	ylabel('t [s]','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'time_comparison_2.pdf']);
	title(p)
	legend(leg0)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

	% Histograms
	colors = {'r','g','b','m'};	
	fig = figure('Visible','off');
	subplot(2,3,1)	
	histogram(Time,'FaceColor','k')
	title('True FM')
	xlabel('t [s]','Interpreter','tex') % "latex" in Matlab
	axis('square')
	for k = 1:4
		subplot(2,3,k+1)	
		histogram(Time_s(:,k+2),'FaceColor',colors{k})
		xlabel('t [s]','Interpreter','tex') % "latex" in Matlab		
		axis('square')
		p = join(['Depth ',int2str(k+2)]);
		title(p)
	end
	file_name = join([dire,'time_comparison_2_hist.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
