function plots_Times(Times_True,Times_Surr,Ind,z,dire,Case)

	% Labels components
	In = (1:length(Times_True))';

	% Legends
	leg = {'True FM'};
	for k = 1:length(Ind)
		leg{1+k} = join(['Nw = ',int2str(z{Ind(k)}.Nw)]);
	end
	
	% Colors
	colors = {'r-','g-','b-','m-'};

	% Plot
	fig = figure('Visible','off');
	semilogy(In,Times_True,'k-')
	hold on
	for jj = 1:length(Ind)
		semilogy(In,Times_Surr(:,jj),colors{jj})
		hold on				
	end
	hold off
	legend(leg)
	xlabel('Experiment','Interpreter','tex') % "latex" in Matlab
	ylabel('t [s]','Interpreter','tex') % "latex" in Matlab
	p = 'Time evaluations';
	title(p)
	file_name = join([dire,Case,'_times.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
