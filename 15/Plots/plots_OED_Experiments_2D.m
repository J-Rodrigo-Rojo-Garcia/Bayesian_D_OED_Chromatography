function plots_OED_Experiments_2D(E,dire,Name,Title,d,d_2,limits)

    % Directory to save

    % Labels
    d_lab = {};
    d_lab{1} = '\tau^{inj}'; d_lab{2} = 'c_{Feed}';
    p_lab = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',...
    'Q','R','S','T','U','V','W','X','Y','Z'};
   
   % Create the grid
   d1 = unique(E(:,1));
   d2 = unique(E(:,2));
   [D1,D2] = meshgrid(d1,d2);
   U = D1;
   for k = 1:length(d1)
   		for m = 1:length(d2)
   			Dx = D1(k,m);
   			Dy = D2(k,m);
   			D = [Dx,Dy];
   			W = vecnorm(E(:,1:2) - D,2,2);
			[r,l] = min(W);
			U(k,m) = E(l,3);
   		end
   end
   
    % 2D
	fig = figure('visible','off');
	pcolor(D1,D2,U)
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';
    set(gca, 'clim', [limits(1) limits(2)]);
    colormap(ax,'parula')
    colorbar
    xlabel(d_lab{1},'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab{2},'Interpreter','tex') % "latex" in Matlab
    title(Title,'Interpreter','tex')
    savefig(join([dire,Name,'.fig']))
    file_name = join([dire,Name,'.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

    % 2D
	fig = figure('visible','off');
	pcolor(D1,D2,U)
	shading interp; 
    ax = gca;
    ax.ColorScale = 'linear';
    set(gca, 'clim', [limits(1) limits(2)]);
    colormap(ax,'parula')
    colorbar
    xlabel(d_lab{1},'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab{2},'Interpreter','tex') % "latex" in Matlab
    for k = 1:length(d_2)
    	text(d_2(k,1),d_2(k,2),p_lab{k})
    end
    title(Title,'Interpreter','tex')
    savefig(join([dire,Name,'.fig']))
    file_name = join([dire,Name,'_with_points.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
