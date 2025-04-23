function plots_OED_Experiments_3D_Opti(E,dire,Name,Title,d,d_opt,fval,d_history,d_ini)

    % Directory to save

    % Labels
    d_lab = {};
    d_lab{1} = 'c_{1}^{Feed}';	d_lab{2} = 'c_{2}^{Feed}'; d_lab{3} = 'u';	
    p_lab = {'A','B','C','D','E'};
   
   	% Legends
	leg = {'Initial point','Trajectories','Optimal point'};
   
   % Data
	d1 = unique(E(:,1));	N1 = length(d1);
	d2 = unique(E(:,2));	N2 = length(d2);
	d3 = unique(E(:,3));	N3 = length(d3);

	[D1,D2,D3] = meshgrid(d1,d2,d3);
	U = D1;
	acum = 0;
	parfor ii = 1:N1
		for jj = 1:N2
			for kk = 1:N3
			    q1 = D1(ii,jj,kk);
			    q2 = D2(ii,jj,kk);			    
			    q3 = D3(ii,jj,kk);			    
			    Id = find(E(:,1) == q1);
			    q = E(Id,:);
			    Id = find(q(:,2) == q2);
			    q = q(Id,:);
			    Id = find(q(:,3) == q3);
			    q = q(Id,:);
				U(ii,jj,kk) = q(4);
			end
		end
	end			

    % Volumen
	fig = figure('visible','on');
	plot3(d_ini(1),d_ini(2),d_ini(3),'ko')
	hold on
	plot3(d_history(:,1),d_history(:,2),d_history(:,3),'k-')
	hold on
	plot3(d_opt(1),d_opt(2),d_opt(3),'ro')
	hold on	
    pcolor3(D1,D2,D3,U,'alpha',0.02)
    ax = gca;
    ax.ColorScale = 'linear';
    colormap(ax,'parula')
    colorbar
    xlabel(d_lab(1),'Interpreter','tex') % "latex" in Matlab
    ylabel(d_lab(2),'Interpreter','tex') % "latex" in Matlab
    zlabel(d_lab(3),'Interpreter','tex') % "latex" in Matlab
    for k = 1:length(d)
    	text(d(k,1),d(k,2),d(k,3),p_lab{k})
    end
%    hold on
    hold off
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
