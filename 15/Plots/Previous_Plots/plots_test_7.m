function plots_test_7(N_th,theta,chain_real,Point,d,dire,burn)

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

    % Number of experiments for design
    Ne = length(d);

	% Bounds
	lbnd = zeros(N_th,1);
	ubnd = lbnd;
	for m = 1:N_th
		Min = theta(m);
		Max = theta(m);
		for k = 1:Ne
			Min_1 = min(chain_real{k}(burn:end,m));
            Min = min(Min_1,Min);
			Max_1 = max(chain_real{k}(burn:end,m));
            Max = max(Max,Max_1);
		end	
		lbnd(m) = Min;
		ubnd(m) = Max;
	end

	% Trace
	ax = 1:N_th;
	for k = 1:N_th
		fig = figure('visible','off');
		for q = 1:Ne
			subplot(Ne,1,q)
			plot(chain_real{q}(1:end,k))
			ylabel(theta_lab(k),'Interpreter','tex')
			title(join(['Point ',Point{q}]))
			if (q == Ne )
           		xlabel('N','Interpreter','tex') % "latex" in Matlab
            else
            	set(gca,'XTick',[])	
            end
             
        end
        p = join(['Trace ', theta_lab(k)]);
        sgtitle(p) 	
        file_name = join([dire,'trace_',int2str(k),'.pdf']);
        set(fig,'Units','Inches');
        pos = get(fig,'Position');
		set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(fig,file_name,'-dpdf','-r0','-r300')
        close(fig)
    end
    
	% Chain
	ax = 1:N_th;
	r = 0;
	for k = 1:N_th
		for L = k+1:N_th
			r = r+1; 
			fig = figure('visible','off');
			for q = 1:Ne
				subplot(2,3,q)
             	binscatter(chain_real{q}(burn:end,k),chain_real{q}(burn:end,L),250);
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
				if (q > 3 )
             		xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
             	else
            		set(gca,'XTick',[])	
             	end
             	if (q == 1  |  q == 4)
             		ylabel(theta_lab(L),'Interpreter','tex') % "latex" in Matlab
             	else
           		set(gca,'YTick',[])	
             	end
%            	axis('equal')
             	p = join(['Point ', Point{q}]);
             	title(p)
             	%legend([z],'Real parameter')
             end
             
             subplot(2,3,6)
             z = plot(1:10,nan(1,10),'mo','LineWidth',1,...
             'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
             hold off
             axis off
             legend({'True'})
             p = join(['Chain ', theta_lab(k),' vs ', theta_lab(L)]);
             sgtitle(p) 	
             file_name = join([dire,'chain_',int2str(r),'.pdf']);
             set(fig,'Units','Inches');
             pos = get(fig,'Position');
			 set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
             print(fig,file_name,'-dpdf','-r0','-r300')
             close(fig)
          end
     end

end
