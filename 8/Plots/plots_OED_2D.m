function plots_OED_2D(E,file_name,Title,d,d_2,limits,Axis,Colorb,Points)

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
	U = D1; Us = D1;
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
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Colorbar

    % 2D - x axis
    fig = figure('visible','off');
    pcolor(D1,D2,U)
    shading interp; 
    ax = gca;
    set(gca,'FontSize',14)    
    ax.ColorScale = 'linear';
    colormap(ax,'parula')
	title(Title,'Interpreter','tex')    
	if (Axis == 0)
		set(gca,'XTick',[],'YTick',[])
   		color = get(fig,'Color');
   		set(gca,'XColor',color,'YColor',color,'TickDir','out')
	elseif (Axis == 1)
		xticks([0.05 1 2 3])
		yticks([1 5 10 15])
   		xticklabels({'0.05','1','2','3'})
		yticklabels({'1','5','10','15'})
	else
		'Error'
		return
	end
	if (Colorb == 1)
    	c = colorbar('location','eastoutside');
    	set(c,'FontSize',14)    
   	end	
   	caxis([limits(1) limits(2)])
	box 'off'
	if (Points == 1) 
    	for k = 1:length(d_2)
    		text(d_2(k,1),d_2(k,2),p_lab{k})
    	end
	end
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0','-r300')
    close(fig)

end
