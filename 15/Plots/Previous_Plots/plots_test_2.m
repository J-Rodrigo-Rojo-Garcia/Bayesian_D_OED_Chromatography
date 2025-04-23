function plots_test_1(t_dat,yr,ys,l,Nw,dire)

    % Fixed degree

	% Data
	Ne = length(l);	 
	Nq = zeros(Ne,1);  	
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
    plot(t_dat,yr,'k-')
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

end
