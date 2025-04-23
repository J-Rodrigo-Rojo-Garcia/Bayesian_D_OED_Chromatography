function plots_test_6(N_th,theta,chain,chain_real,Point,depth,dire,burn)

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

	% Bounds
	lbnd = zeros(N_th,1);
	ubnd = lbnd;

	for m = 1:N_th
		Min = min(chain_real(burn:end,m));
		Max = max(chain_real(burn:end,m));
		for k = 1:length(depth)
			Min = min(Min,min(chain{depth(k)}(burn:end,m)));
			Max = max(Max,max(chain{depth(k)}(burn:end,m)));
		end
		lbnd(m) = min(Min,min(theta(m)));
		ubnd(m) = max(Max,max(theta(m)));
	end
    
    % Number of experiments for design
    Ne = length(depth);
        
	% Chain
	ax = 1:N_th;
	r = 0;
	for k = 1:N_th
		for L = k+1:N_th
			r = r+1; 
			fig = figure('visible','off');
			for q = 1:Ne
				subplot(2,2,q)
             	binscatter(chain{depth(q)}(burn:end,k),chain{depth(q)}(burn:end,L),250);
             	ax = gca;
             	ax.ColorScale = 'log';
             	colormap(ax,'jet')
             	colorbar('off')
             	hold on
             	z = plot(theta(k),theta(L),'mo','LineWidth',1,...
             	'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
             	hold on
            	xlim([lbnd(k) ubnd(k)])
            	ylim([lbnd(L) ubnd(L)])
				if (q > 5 )
             		xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
             	else
            		set(gca,'XTick',[])	
             	end
             	if (mod(q,2) == 1)
             		ylabel(theta_lab(L),'Interpreter','tex') % "latex" in Matlab
             	else
           		set(gca,'YTick',[])	
             	end
%            	axis('equal')
             	p = join(['Depth = ', int2str(depth(q))]);
             	title(p)
             	%legend([z],'Real parameter')
             end
             
             subplot(2,2,3)
			 binscatter(chain_real(burn:end,k),chain_real(burn:end,L),250);
             ax = gca;
             ax.ColorScale = 'log';
             colormap(ax,'jet')
             colorbar('off')
             hold on
             z = plot(theta(k),theta(L),'mo','LineWidth',1,...
             'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
             hold on
             xlim([lbnd(k) ubnd(k)])
             ylim([lbnd(L) ubnd(L)])
             xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
             title('True Forward Mapping')

             subplot(2,2,4)
             z = plot(1:10,nan(1,10),'mo','LineWidth',1,...
             'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
             hold off
             axis off
             legend({'True'})
             p = join(['Chain ', theta_lab(k),' vs ', theta_lab(L),'. Point ',Point]);
             sgtitle(p) 	
             file_name = join([dire,'Point_',Point,'_chain_',int2str(r),'.pdf']);
             set(fig,'Units','Inches');
             pos = get(fig,'Position');
			 set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
             print(fig,file_name,'-dpdf','-r0','-r300')
             close(fig)
          end
     end

end
