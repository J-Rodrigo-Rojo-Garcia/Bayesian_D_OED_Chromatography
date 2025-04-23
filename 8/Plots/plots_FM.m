function plots_FM(t_dat,t,c,cI,Nc,dire,name,Title)


	% Labels components
	c_lab = {};
	for k = 1:Nc
		c_lab{k} = sprintf('c_{%d}',k);
	end

	% Legends
	leg = {'True FM','Obs nodes'};
	
	% Limits
	c_min = min(-1,min(min(c)));
	c_max = max(max(c)) + 5;

	% Plot
	fig = figure('Visible','off');
	for k = 1:Nc
		subplot(Nc,1,k)
		plot(t,c(:,k),'k')
		hold on
		plot(t_dat,cI(:,k),'ko')		
		hold off
		ylabel(c_lab{k})
		ylim([c_min c_max])
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
