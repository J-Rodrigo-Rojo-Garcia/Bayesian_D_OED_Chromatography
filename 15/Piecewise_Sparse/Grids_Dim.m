function X = Grids_Dim(dim,lbnd,ubnd,depth,type_S,Sparse)

	% Allocate grid 
	X = {};
	
	% Grids
	for k = 1:length(depth)
		X{k} = Grid_Generator(dim,lbnd,ubnd,depth(k),type_S,Sparse);
	end	

end
