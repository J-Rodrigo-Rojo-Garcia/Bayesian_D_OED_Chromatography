function plots_data(t_dat,t,c,cI,c_surr,data,depth,Depth_max,Nc,dire,name,Title)


	% Labels components
	c_lab = {};
	for k = 1:Nc
		c_lab{k} = sprintf('c_{%d}',k);
	end
	
	% Legends
	leg = {};
	leg{1} = 'True FM'; leg{2} = 'Obs Nodes'; leg{3} = 'Data';
	for k = 1:Depth_max
		leg{3+k} = join(['Depth =  ',int2str(k)]);
	end		

	% Colors
%	colors = {'k-','ko-','r*-','gs-','b+-','md-','cx-','yp-'};
	colors = {'k-','ko-','r.-','g.-','b.-','c.-','m.-','y.-'};

	% Limits
	c_min = min(-1,min(min(c)));
	c_max = max(max(c)) + 5;

	% Plot
	fig = figure('Visible','off');
	for k = 1:Nc
		subplot(Nc,1,k)
		plot(t,c(:,k),colors{1})
		hold on
		plot(t_dat,cI(:,k),colors{2})		
		hold on
		plot(t_dat,data(:,k),colors{3})		
		hold on
		for m = 1:Depth_max
			plot(t_dat,c_surr{m}(:,k),colors{3+m})		
			hold on
		end
		hold off
		ylabel(c_lab{k})
%		ylim([c_min c_max])
		legend(leg)
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	sgtitle(Title)
	file_name = join([dire,name,'.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
