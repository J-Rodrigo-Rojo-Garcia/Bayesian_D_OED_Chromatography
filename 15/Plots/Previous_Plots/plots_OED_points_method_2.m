function plots_OED_points(yr,t_dat,t,C,d,dire,chain,N_th,T_type,burn,theta)

    % Labels
    p_lab = {'A','B','C','D','E'};

    % Labels
    theta_lab = {}; 
    for k = 1:N_th
        theta_lab{k} = sprintf('\\theta_{%d}',k);
    end

	% Size	
	[N_OED,N] = size(d);
    Nd = length(t_dat);
    
    % Index
	I1 = 1:Nd;
    I2 = Nd+1:2*Nd;

    % Points
    for k = 1:N_OED
    
		fig = figure('visible','off');
		subplot(2,1,1)
		plot(t_dat,yr{k}(I1),"ro")
		hold on
    	plot(t{k},C{k}(1,:),"r-")
    	hold off
    	xlabel("t",'Interpreter','tex') % "latex" in Matlab
    	ylabel("c",'Interpreter','tex') % "latex" in Matlab
    	tit = join(['Simulation, Point ',p_lab{k}]);
    	title(tit)
    	legend({'True','Surrogated'},'Location', 'Best')

		subplot(2,1,2)
		plot(t_dat,yr{k}(I2),"bo")
		hold on
    	plot(t{k},C{k}(2,:),"b-")

    	xlabel("t",'Interpreter','tex') % "latex" in Matlab
    	ylabel("c",'Interpreter','tex') % "latex" in Matlab
    	legend({'True','Surrogated'},'Location','Best')
    	set(fig,'Units','Inches');
    	pos = get(fig,'Position');
 set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
    	file_name = join([dire,'FM_',p_lab{k},'.pdf']);
    	print(fig,file_name,'-dpdf','-r0')
    	close(fig)
    end

	% Burning cutting
	beg = burn;

	% Min-Max values
	Xmin = zeros(N_th,1); Xmax = Xmin; 
	Min = zeros(N_OED,1);
	Max = Min;
	
	for k = 1:N_th
	
		for q = 1:N_OED
			Min(q) = min(chain{q}(beg:end,k)); 
			Max(q) = max(chain{q}(beg:end,k)); 
		end
		
		Xmin(k) = min(Min);
		Xmin(k) = min(Xmin(k),theta(k));
		Xmax(k) = max(Max);
		Xmax(k) = max(Xmax(k),theta(k));

    end

    % Type between surrogated and true models
    if (T_type == 'S')
        % Directory
        dire = join([dire,'/Surrogated/']);
        % Filenames
        chain_name = 'surrogated_chain_';
        hist_name = 'surrogated_hist_';
        trace_name = 'surrogated_trace_';
        % Title
        chain_title = 'Chain (Surrogated)';
        hist_title = 'Histogram (Surrogated)';
        trace_title = 'Trace (Surrogated)';

    elseif (T_type == 'T')
        % Directory
        dire = join([dire,'/True/']);
        % Filenames
        chain_name = 'true_chain_';
        hist_name = 'true_hist_';
        trace_name = 'true_trace_';
        % Title
        chain_title = 'Chain (True)';
        hist_title = 'Histogram (True)';
        trace_title = 'Trace (True)';        
        
    else
        'Invalid plot case'
        return
    end


	% Chain
	ax = 1:N_th;
	r = 0;
    for k = 1:N_th
    	for L = k+1:N_th
            r = r+1; 
            
            % Plot Surrogated
            fig = figure('visible','off');
            for q = 1:N_OED
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
	            p = join(['Point ', p_lab{q}]);
            	title(p)
            	%legend([z],'Real parameter')
            end
            subplot(2,3,6)
            z = plot(1:10,nan(1,10),'mo','LineWidth',1,...
            'MarkerEdgeColor','k','MarkerFaceColor','k','MarkerSize',3);
            hold off
            axis off
            legend({'True'})
            p = join([chain_title, theta_lab(k),' vs ', theta_lab(L)]);
            sgtitle(p) 	
            file_name = join([dire,chain_name,int2str(r),'.pdf']);
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
		for q = 1:N_OED
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
	        p = join(['Point ', p_lab{q}]);
            title(p)
		end
            
		p = join([hist_title, theta_lab(k)]);
		sgtitle(p) 	
        file_name = join([dire,hist_name,int2str(k),'.pdf']);
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
		for q = 1:N_OED
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

	        p = join(['Point ', p_lab{q}]);
            title(p)
		end
            
		p = join([trace_title, theta_lab(k)]);
		sgtitle(p) 	
        file_name = join([dire,trace_name,int2str(k),'.png']);
		saveas(fig,file_name)
        close(fig)

    end    
        
end
