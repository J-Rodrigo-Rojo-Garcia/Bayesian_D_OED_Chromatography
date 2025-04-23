function plots_MSE_piecewise(MSE,titles,names)	

	% Plots
	fig = figure('visible','off');
    h = histogram(MSE,100);
    h.FaceColor = 'r';
    xlabel("MSE",'Interpreter','tex') % "latex" in Matlab
    ylabel("Experiments",'Interpreter','tex') % "latex" in Matlab
	title(titles)
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	filename = names;
	print(fig,filename,'-dpdf','-r0')
    close(fig)

end
