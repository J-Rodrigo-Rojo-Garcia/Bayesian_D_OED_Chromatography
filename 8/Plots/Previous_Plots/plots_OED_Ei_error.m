function plots_OED_Ei_error(D1,D2,U,Us,dire,filename,Title,d,min_E,max_E)

    % Labels
    d_lab = {};
	d_lab{1} = 'c_{1}^{Feed}';	d_lab{2} = 'c_{2}^{Feed}'; 
    

    
    % Volumen
	fig = figure('visible','off');
    pcolor(D1,D2,abs(U-Us))
    caxis([min_E,max_E])
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';
    colormap(ax,'turbo')
    colorbar
    xlabel(d_lab(1),'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab(2),'Interpreter','tex') % "latex" in Matlab
    title(Title)
    file_name = join([dire,filename]);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
