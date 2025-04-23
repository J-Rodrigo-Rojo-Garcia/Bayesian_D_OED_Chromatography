function plots_error_2(Error,dire,Name,Title,d0)

    % Labels
   d_lab = {};
   d_lab{1} = '\tau^{inj}'; d_lab{2} = 'c_{Feed}';
   
   % Create the grid
   d1 = unique(d0(:,1));
   d2 = unique(d0(:,2));
   [D1,D2] = meshgrid(d1,d2);
   E = D1;
   for k = 1:length(d1)
   		for m = 1:length(d2)
   			Dx = D1(k,m);
   			Dy = D2(k,m);
   			D = [Dx,Dy];
   			W = vecnorm(d0 - D,2,2);
			[r,l] = min(W);
			E(k,m) = Error(l);
   		end
   end
   
    % 2D
	fig = figure('visible','off');
	pcolor(D1,D2,E)
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';
    colormap(ax,'parula')
    colorbar
    xlabel(d_lab{1},'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab{2},'Interpreter','tex') % "latex" in Matlab
    title(Title)
    savefig(join([dire,Name,'.fig']))
    file_name = join([dire,Name,'.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
