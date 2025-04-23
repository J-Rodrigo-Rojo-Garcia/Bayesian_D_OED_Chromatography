function plots_OED_Ei_opt(D1,D2,U,dire,filename,Title,d_ini,d_history,d_opt,min_U,max_U)

    % Labels
    d_lab = {};
	d_lab{1} = 'c_{1}^{Feed}';	d_lab{2} = 'c_{2}^{Feed}'; 

	% Legend
	leg = {'','Initial point','Trajectories','Optimal point'};	
    
    % Volumen
	fig = figure('visible','off');
    pcolor(D1,D2,U)
%	caxis([min_U,max_U])
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';
    colormap(ax,'parula')
    colorbar
    hold on
	plot(d_ini(1),d_ini(2),'ko')
	hold on
	plot(d_history(:,1),d_history(:,2),'k-')
	hold on
	plot(d_opt(1),d_opt(2),'ro')
	hold off				
    xlabel(d_lab(1),'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab(2),'Interpreter','tex') % "latex" in Matlab
    title(Title)
    legend(leg,'Location','southeast')
    file_name = join([dire,filename]);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
