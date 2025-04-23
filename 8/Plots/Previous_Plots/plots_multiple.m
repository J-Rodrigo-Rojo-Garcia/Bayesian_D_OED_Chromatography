function plots_multiple(t_dat,yr,ys,d,l,Nw,Std,N_th,theta,chain,par_w,dire)

	% Directory
%	dire = "Plots/Results/Multiple_FM/";

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

	% Data
	Ne = length(l);	 Np = zeros(Ne,1);  Nq = zeros(Ne,1);  	
	for k = 1:Ne
		Nq(k) = Nw{k};
	end

	% Colors
	colors = {"ro-","gs-","b+-","cd-","m*-"};	
	
	% Legends
    leg1 = {};
    leg1{1} = 'True'; 
    for k = 1:Ne
		leg1{k+1} = join(['l = ', int2str(l(k)),', Nq = ', int2str(Nq(k))]);	    
    end

	% Index
	Nd = length(yr)/2;
	I1 = 1:Nd;
	I2 = (Nd+1):2*Nd;
	I3 = 1:2*Nd;

	% Plots
	fig = figure('visible','off');
	subplot(2,1,1)
    plot(t_dat,yr(I1),'k-')
	hold on
	for k = 1:Ne
		plot(t_dat,ys{k}(I1),colors{k})
		hold on
	end
	hold off	
    xlabel("t",'Interpreter','tex') % "latex" in Matlab
    ylabel("c",'Interpreter','tex') % "latex" in Matlab
    tit = join(['Forward Mapping c1,    ', 'd1 = ', num2str(d(2)), ', d2 = ', num2str(d(3))]);	
	title(tit)
    legend(leg1,'Location','Best')
    
	subplot(2,1,2)
    plot(t_dat,yr(I2),'k')
	hold on
	for k = 1:Ne
		plot(t_dat,ys{k}(I2),colors{k})
		hold on
	end	
	hold off	
    xlabel("t",'Interpreter','tex') % "latex" in Matlab
    ylabel("c",'Interpreter','tex') % "latex" in Matlab
    tit = join(['Forward Mapping c2,    ', 'd1 = ', num2str(d(2)), ', d2 = ', num2str(d(3))]);	
	title(tit)
    legend(leg1,'Location','northwest')%'Best')
    set(fig,'Units','Inches');
    pos = get(fig,'Position');
    set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	file_name = join([dire,'Surrogated_FMs_',num2str(d(1)),'_',num2str(d(2)),'_',num2str(d(3)),'.pdf']);
	print(fig,file_name,'-dpdf','-r0')
    close(fig)
    
	% Burning cutting
	beg = 2*(10^4);

	% Min-Max values
	Xmin = zeros(N_th,1); Xmax = Xmin; 
	Min = zeros(Ne,1);
	Max = Min;
	
	for k = 1:N_th
	
		for q = 1:Ne
			Min(q) = min(chain{q}(beg:end,k)); 
			Max(q) = max(chain{q}(beg:end,k)); 
		end
		
		Xmin(k) = min(Min);
		Xmin(k) = min(Xmin(k),theta(k));
		Xmax(k) = max(Max);
		Xmax(k) = max(Xmax(k),theta(k));

	end
  
	% Chain
	ax = 1:N_th;
	r = 0;
    for k = 1:N_th
    	for L = k+1:N_th
            r = r+1; 
            
            % Plot
            fig = figure('visible','off');
            for q = 1:Ne
            	subplot(2,3,q)
            	binscatter(chain{q}(beg:end,k),chain{q}(beg:end,L),250);
            	ax = gca;
            	ax.ColorScale = 'log';
            	colormap(ax,'jet')
            	colorbar('off')
            	hold on
            	z = plot(theta(k),theta(L),'mo','LineWidth',1,...
            	'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
            	hold on
            	xlim([Xmin(k) Xmax(k)])
            	ylim([Xmin(L) Xmax(L)])
            	if (q > 2 )
            		xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
            	else
%            		set(gca,'XTick',[])	
            	end
            	if (mod(q,3) == 1)
            		ylabel(theta_lab(L),'Interpreter','tex') % "latex" in Matlab
            	else
 %           		set(gca,'YTick',[])	
            	end
%            	axis('equal')
	            p = join(['l = ', int2str(l(q))]);
            	title(p)
            	%legend([z],'Real parameter')
            end
            subplot(2,3,6)
            z = plot(1:10,nan(1,10),'mo','LineWidth',1,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
            hold off
            axis off
            legend({'True'})
            p = join(['Chain (Surrogated)', theta_lab(k),' vs ', theta_lab(L)]);
            sgtitle(p) 	
            file_name = join([dire,'surrogated_chain_',int2str(r),'.pdf']);
            set(fig,'Units','Inches');
            pos = get(fig,'Position');
			set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
            print(fig,file_name,'-dpdf','-r0','-r300')
            close(fig)
		end            
	end
	
    % Histograms
    ax = 1:N_th;
    for k = 1:N_th

    	% SURROGATED
        fig = figure('visible','off');
		for q = 1:Ne
			subplot(2,3,q)
			hist(chain{q}(beg:end,k),50,"facecolor", "r", "edgecolor", "r");
			hold on
			if (q > 2 )
				xlabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
%			else
%				set(gca,'XTick',[])	
			end
			
			if (mod(q,3) == 1)
				ylabel('N','Interpreter','tex') % "latex" in Matlab
%			else
%				set(gca,'YTick',[])	
			end
	        p = join(['l = ', int2str(l(q))]);
            title(p)
		end
            
		p = join(['Histograms (Surrogated)', theta_lab(k)]);
		sgtitle(p) 	
        file_name = join([dire,'surrogated_hist_',int2str(k),'.pdf']);
        set(fig,'Units','Inches');
        pos = get(fig,'Position');
		set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
        print(fig,file_name,'-dpdf','-r0','-bestfit')
        close(fig)

    end

    % Traces
    ax = 1:N_th;
    for k = 1:N_th
    
    	% SURROGATED
        fig = figure('visible','off');
		for q = 1:Ne
			subplot(2,3,q)
			plot(chain{q}(:,k),'b.-')
			ylim([Xmin(k) Xmax(k)])

			hold on
			if (q > 2 )
				xlabel('N','Interpreter','tex') % "latex" in Matlab
			else
				set(gca,'XTick',[])	
			end
			
			if (mod(q,3) == 1)
				ylabel(theta_lab(k),'Interpreter','tex') % "latex" in Matlab
			else
				set(gca,'YTick',[])	
			end
			%axis('equal')

	        p = join(['l = ', int2str(l(q))]);
            title(p)
		end
            
		p = join(['Traces (Surrogated)', theta_lab(k)]);
		sgtitle(p) 	
        file_name = join([dire,'surrogated_trace_',int2str(k),'.png']);
		saveas(fig,file_name)
        close(fig)

    end    

end
