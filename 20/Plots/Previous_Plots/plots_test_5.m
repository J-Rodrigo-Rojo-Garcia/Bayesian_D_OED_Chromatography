function plots_test_5(N_th,theta_real,chain,dire,Type,burn)

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end
    
    % Chain
    ax = 1:N_th;
    r = 0;
    for k = 1:N_th
         for l = k+1:N_th
            r = r+1; 
            fig = figure('visible','off');
            binscatter(chain(burn:end,k),chain(burn:end,l),250);
            ax = gca;
            ax.ColorScale = 'log';
            colormap(ax,'jet')
            colorbar('off')
            hold on
            z = plot(theta_real(k),theta_real(l),'mo','LineWidth',1,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',5);
            hold off
            xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
            ylabel(theta_lab(l),'Interpreter','tex') % "latex" in Matlab
            p = join(['Chain ',Type,'.', theta_lab(k),' vs ', theta_lab(l)]);
            title(p)
            legend([z],'Real parameter')
            file_name = join([dire,'Chain_',Type,'_',int2str(r),'.pdf']);
            set(fig,'Units','Inches');
            pos = get(fig,'Position');
            set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
            print(fig,file_name,'-dpdf','-r0')
            close(fig)
         end
    end

    % Traces
    fig = figure('visible','off');
    title('Trace')
    for k = 1:N_th	
    	subplot(5,1,k)
    	plot(chain(:,k),'b.-')
    	ylabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
        if (k == 1)
			p = join(['Trace ',Type]);
            title(p)
        end
    end
    xlabel('N','Interpreter','tex') % "latex" in Matlab
    file_name = join([dire,'trace.png']);
    saveas(fig,file_name)
    close(fig)
    
    % Histograms
    fig = figure('visible','off');
    for k = 1:N_th	
    	subplot(N_th,1,k)
    	hist(chain(burn:end,k),50,"facecolor", "r", "edgecolor", "b");
        xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
    	ylabel('N','Interpreter','tex') % "latex" in Matlab
    	if (k == 1)
    		p = join(['Histograms ',Type]);
            title(p)
        end
        
     end
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

    file_name = join([dire,Type,'_hist_theta.pdf']);
    print(fig,file_name,'-dpdf','-r0')
    close(fig)
end
