function plots_OED_Experiments_2D_Opti(E,dire,Name,Title,d,d_opt,fval,d_history,d_ini)

    % Directory to save

    % Labels
    d_lab = {};
    d_lab{1} = 'c^{Feed}'; d_lab{2} = 'u';
    p_lab = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',...
    'Q','R','S','T','U','V','W','X','Y','Z'};

	leg = {'Initial point','Trajectory','End point'};

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
	fig = figure('visible','on');
	plot(d_ini(1),d_ini(2),'ko')
	hold on
	plot(d_history(:,1),d_history(:,2),'k-')
	hold on
	plot(d_opt(1),d_opt(2),'ro')
	hold on	
	pcolor(D1,D2,U)
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
	
%    caxis([min_E,max_E])
    xlabel(d_lab{1},'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab{2},'Interpreter','tex') % "latex" in Matlab
    for k = 1:length(d)
    	text(d(k,1),d(k,2),p_lab{k})
    end
    title(Title)
    legend(leg)
    savefig(join([dire,Name,'.fig']))
    file_name = join([dire,Name,'.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
