function X = Grid_Generator(dim,lbnd,ubnd,depth,type_S,Sparse)

	% Function
	fun = @(x) 0;
	
	% Keep Grid
	Grid = 'on';
	
	% Training process
	z = training_process_vect(fun,dim,1,lbnd,ubnd,depth,type_S,Sparse,Grid);

	% Grid
	X = z.grid;

end
