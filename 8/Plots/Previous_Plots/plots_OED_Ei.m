function plots_OED_Ei(D1,D2,U,dire,filename,Title,d,min_U,max_U)

    % Labels
    d_lab = {};
	d_lab{1} = 'c_{1}^{Feed}';	d_lab{2} = 'c_{2}^{Feed}'; 
    p_lab = {'A','B','C','D','E'};
    
    % Volumen
	fig = figure('visible','off');
    pcolor(D1,D2,U)
%    caxis([min_U,max_U])
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';

    colormap(ax,'parula')
    colorbar
    xlabel(d_lab(1),'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab(2),'Interpreter','tex') % "latex" in Matlab
    for k = 1:length(d)
    	text(d(k,1),d(k,2),p_lab{k},'Color','red','FontSize',14)
    end
    title(Title)
    file_name = join([dire,filename]);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
