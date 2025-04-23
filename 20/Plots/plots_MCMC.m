function plots_MCMC(N_th,theta_real,chain,dire,burn,Title,pre_name,lbnd,ubnd,R)
    % Labels
    theta_lab = {}; 

    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

    p_lab = {'A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P',...
    'Q','R','S','T','U','V','W','X','Y','Z'};
    
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
            p = join(['Chain ',Title,'.', theta_lab(k),' vs ', theta_lab(l) '. Point ',p_lab(R)]);
            axis([lbnd(k) ubnd(k) lbnd(l) ubnd(l)])	
            title(p)
            legend([z],'Real parameter')
%           	text(Point(1),Point(2),p_lab{R})
            file_name = join([dire,'Chain_',pre_name,'_',int2str(r),'.pdf']);
            set(fig,'Units','Inches');
            pos = get(fig,'Position');
            set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
            print(fig,file_name,'-dpdf','-r0')
            close(fig)
         end
    end


    % Histograms
    fig = figure('visible','off');
    for k = 1:N_th	
    	subplot(N_th,1,k)
    	hist(chain(burn:end,k),50,"facecolor", "r", "edgecolor", "b");
        xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
    	ylabel('N','Interpreter','tex') % "latex" in Matlab
    	if (k == 1)
    		p = join(['Histograms ',Title,'. Point ',p_lab(R)]);
            title(p)
        end
        
     end
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
        set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])

    file_name = join([dire,pre_name,'_hist_theta.pdf']);
    print(fig,file_name,'-dpdf','-r0')
    close(fig)
    
end
