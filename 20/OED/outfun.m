function stop = outfun(x,optimvalues,state);
	stop = false;
	if isequal(state,'iter')
		history = [history; x];
	end
end

