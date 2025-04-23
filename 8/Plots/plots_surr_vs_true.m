function plots_surr_vs_true(tao_dat,c_true_best,c_true_worst,c_best,c_worst,depths,N,dire)

	% Labels components
	c_lab = {};
	for k = 1:2
		c_lab{k} = sprintf('c_{%d}',k);
	end

	% Legends
	leg0 = {'Obs nodes'};
	Depth_max = length(depths);
	for k = 1:Depth_max
		leg0{1+k} = join(['Nw = ',int2str(N(k))]);
	end

	% Colors
	colors = {'ro-','g*-','ms-','cd-','bs-'};

	% Limits
%	c_min_best = min(-1,min(min(c_true)));
%	c_min_best = min(c_min_best,min(min(c_best)));
%	c_max_best = max(max(max(c_true)),max(max(c_best))) + 5;

%	c_min_worst = min(-1,min(min(c_true)));
%	c_min_worst = min(c_min_worst,min(min(c_worst)));
%	c_max_worst = max(max(max(c_worst)),max(max(c_worst))) + 5;

	% Plots 
	fig = figure('Visible','off');
	p = 'Absolute error';
	subplot(2,1,1)
	plot(tao_dat,c_true_best(:,1),'k.-')
	hold on
	for k = 1:Depth_max
		plot(tao_dat,c_best{k}(:,1),colors{k})
		hold on
	end	
	title('Comparison best cases')
	hold off
%	xlabel('tao','Interpreter','tex') % "latex" in Matlab
	ylabel(c_lab{1},'Interpreter','tex') % "latex" in Matlab
	legend(leg0)

	subplot(2,1,2)
	plot(tao_dat,c_true_best(:,2),'k.-')
	hold on
	for k = 1:Depth_max
		plot(tao_dat,c_best{k}(:,2),colors{k})
		hold on
	end	
	hold off
	xlabel('tao','Interpreter','tex') % "latex" in Matlab
	ylabel(c_lab{2},'Interpreter','tex') % "latex" in Matlab
	legend(leg0)
	file_name = join([dire,'_best.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)


	fig = figure('Visible','off');
	p = 'Absolute error';
	subplot(2,1,1)
	plot(tao_dat,c_true_worst(:,1),'k.-')
	hold on
	for k = 1:Depth_max
		plot(tao_dat,c_worst{k}(:,1),colors{k})
		hold on
	end	
	title('Comparison best cases')
	hold off
%	xlabel('tao','Interpreter','tex') % "latex" in Matlab
	ylabel(c_lab{1},'Interpreter','tex') % "latex" in Matlab
	legend(leg0)

	subplot(2,1,2)
	plot(tao_dat,c_true_worst(:,2),'k.-')
	hold on
	for k = 1:Depth_max
		plot(tao_dat,c_worst{k}(:,2),colors{k})
		hold on
	end	
	hold off
	xlabel('tao','Interpreter','tex') % "latex" in Matlab
	ylabel(c_lab{2},'Interpreter','tex') % "latex" in Matlab
	legend(leg0)
	file_name = join([dire,'_worst.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
