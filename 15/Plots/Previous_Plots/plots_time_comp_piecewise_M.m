function plots_time_comp_piecewise(t,depth,titles,name,dire,col)

	% Colors
	colors = {'r','g','b'};

	% Plots
	fig = figure('visible','off');
    bar(depth,t,colors{col})
    hold on
    xlabel("Depth",'Interpreter','tex') % "latex" in Matlab
    ylabel("Relative time",'Interpreter','tex') % "latex" in Matlab
	title(titles)
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	filename = join([dire,name]);
	print(fig,filename,'-dpdf','-r0')
    close(fig)

end
