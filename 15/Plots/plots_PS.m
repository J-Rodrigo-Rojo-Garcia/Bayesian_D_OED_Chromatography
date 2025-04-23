function plots_PS(t_dat,t,c,cI,cs,Nc,Ind,z,dire,Case)


	% Labels components
	c_lab = {};
	for k = 1:Nc
		c_lab{k} = sprintf('c_{%d}',k);
	end

	% Legends
	leg = {'True FM','Obs nodes'};
	for k = 1:length(Ind)
		leg{2+k} = join(['Nw = ',int2str(z{Ind(k)}.Nw)]);
	end
	
	% Colors
	colors = {'ro-','g*-','ms-','cd-'};

	% Limits
	c_min = min(-1,min(min(c)));
	c_max = max(max(c)) + 5;

	Ax = zeros(1,2*Nc);
	for k = 1:length(Ax)
		if (mod(k,2) == 1)
			Ax(k) = c_min;
		else
			Ax(k) = c_max;	
	end

	% Plot
	fig = figure('Visible','off');
	p = 'Surrogated model';
	title(p)
	for k = 1:Nc
		subplot(Nc,1,k)
		plot(t,c(:,k),'k')
		hold on
		plot(t_dat,cI(:,k),'k.')		
		hold on
		for jj = 1:length(Ind)
			plot(t_dat,cs{Ind(jj)}(:,k),colors{jj})
			hold on				
		end
		hold off
		ylabel(c_lab{k})
		ylim([c_min c_max])
		legend(leg)
	end
	subplot(Nc,1,Nc)
	xlabel('t','Interpreter','tex') % "latex" in Matlab
	file_name = join([dire,'surrogated_test_',Case,'.pdf']);
	set(fig,'Units','Inches');
	pos = get(fig,'Position');
	set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
	print(fig,file_name,'-dpdf','-r0')
	close(fig)

end
