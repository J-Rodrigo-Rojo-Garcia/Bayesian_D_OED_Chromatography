function plots_random(t,t_dat,ck1,ck2,ck3,ck4,ck5,ck6,Nc,tao_inj,c_inj,b1,b2,Qs,Ntp,M,dire)

	% Colors
	colors = {'r-','g-','m-','c-','b-','k-'};
	colors_2 = {'ro','g*','ms','cd','bs','k.'};	

	% Labels components
	c_lab = {};
	for k = 1:Nc
		c_lab{k} = sprintf('c_{%d}',k);
	end

	% Legends
	leg1 = {}; 	leg2 = {}; 	leg3 = {};	leg4 = {};	leg5 = {};	leg6 = {};	
	for k = 1:M
		leg1{k} = join(['b1 = ',num2str(b1(k),'%.3f')]);
		leg2{k} = join(['b2 = ',num2str(b2(k),'%.3f')]);
		leg3{k} = join(['Qs = ',num2str(Qs(k),'%.3f')]);
		leg4{k} = join(['Ntp = ',num2str(Ntp(k),'%.3f')]);
		leg5{k} = join(['tao_inj = ',num2str(tao_inj(k),'%.3f')]);
		leg6{k} = join(['c_Feed = ',num2str(c_inj(k),'%.3f')]);
	end
	
	% Plots b1
	fig = figure('Visible','off');
	p = 'Perturbations respect to b1';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck1{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck1{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg1,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_b1.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

	% Plots b2
	fig = figure('Visible','off');
	p = 'Perturbations respect to b2';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck2{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck2{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg2,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_b2.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

	% Plots Qs
	fig = figure('Visible','off');
	p = 'Perturbations respect to Qs';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck3{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck3{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg3,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_Qs.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)	
	
	% Plots Ntp
	fig = figure('Visible','off');
	p = 'Perturbations respect to Ntp';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck4{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck4{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg4,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_Ntp.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)	

	% Plots tao_inj
	fig = figure('Visible','off');
	p = 'Perturbations respect to tao_inj';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck5{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck5{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg5,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_tao_inj.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)	

	% Plots c_Feed
	fig = figure('Visible','off');
	p = 'Perturbations respect to c_Feed';
	for k = 1:Nc
		subplot(Nc,1,k)
		% Total Forward Mapping
		for jj = 1:M
			plot(t_dat,ck6{jj,2}(:,k),colors_2{jj})
			hold on								
		end
		% Observation nodes		
		for jj = 1:M
			plot(t,ck6{jj,1}(:,k),colors{jj})
			hold on
		end
		hold off
		ylabel(c_lab{k})
		legend(leg6,'Location', 'Best')
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'perturbation_c_Feed.pdf']);
	sgtitle(p)
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)	

end
