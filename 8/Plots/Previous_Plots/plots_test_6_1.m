function plots_test_6_1(data,y,Point,t_dat,dire)

	leg1 = {'True','Data'};
    
    % Plots
    fig = figure('visible','off');
    subplot(2,1,1)
    plot(t_dat,y(:,1),'k-')
	hold on
    plot(t_dat,data(:,1),'ro-')
	hold off
	xlabel("t",'Interpreter','tex') % "latex" in Matlab
	ylabel("c",'Interpreter','tex') % "latex" in Matlab
	tit = join(['Component c1. Point ',Point]);	
	title(tit)
	legend(leg1,'Location','eastoutside')
	legend('Orientation','vertical')
	legend('boxoff')
		    
	subplot(2,1,2)
    plot(t_dat,y(:,2),'k-')
	hold on
    plot(t_dat,data(:,2),'ro-')
	hold off
	xlabel("t",'Interpreter','tex') % "latex" in Matlab
	ylabel("c",'Interpreter','tex') % "latex" in Matlab
	tit = join(['Component c2. Point ',Point]);	
	title(tit)
	%%legend(leg1,'Location','northwest')%'Best')
	legend(leg1,'Location','eastoutside')
	legend('Orientation','vertical')
	legend('boxoff')
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	file_name = join([dire,'FM_data_',Point,'.pdf']);
	print(fig,file_name,'-dpdf','-r0')
    close(fig)


end
