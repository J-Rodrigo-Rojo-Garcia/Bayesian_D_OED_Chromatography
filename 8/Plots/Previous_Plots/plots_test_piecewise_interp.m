function plots_test_piecewise_interp(t_dat,yr,ys,Nw,depth,dire,titles,names)

    % Fixed degree

	% Data
	N = length(Nw);	 

	% Colors
	colors = {"ro-","gs-","b+-","cd-","m*-"};
	
	% Legends
    leg1 = {};
    leg1{1} = 'True'; 
    for k = 1:N
		leg1{k+1} = join(['Depth = ', int2str(depth(k)),', Nw = ', int2str(Nw(k))]);	    
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
    for k = 1:N
	    plot(t_dat,ys{k}(I1),colors{k})
	    hold on
    end
    hold off	
	xlabel("t",'Interpreter','tex') % "latex" in Matlab
	ylabel("c",'Interpreter','tex') % "latex" in Matlab
	tit = join([titles,'c1']);	
	title(tit)
	legend(leg1,'Location','eastoutside')
	legend('Orientation','vertical')
	legend('boxoff')
		    
	subplot(2,1,2)
	plot(t_dat,yr(I2),'k-')
	hold on
	for k = 1:N
		plot(t_dat,ys{k}(I2),colors{k})
		hold on
	end	
	hold off	
	xlabel("t",'Interpreter','tex') % "latex" in Matlab
	ylabel("c",'Interpreter','tex') % "latex" in Matlab
	tit = join([titles,'c2']);	
	title(tit)
	%%legend(leg1,'Location','northwest')%'Best')
	legend(leg1,'Location','eastoutside')
	legend('Orientation','vertical')
	legend('boxoff')
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	file_name = join([dire,names,'.pdf']);
	print(fig,file_name,'-dpdf','-r0')
    close(fig)

end
