function z = training_process(fun,N_th,Nd,lbnd,ubnd,depth,type_S,Sparse)

	% Grid type %
	
	% Clenshaw-Curtis
	if (type_S == 'CC')
		type_G = 'Clenshaw-Curtis';
	% Maximum norm
	elseif (type_S == 'MX')
		type_G = 'Maximum';
	elseif (type_S == 'NB')
		type_G = 'NoBoundary';
	elseif (type_S == 'CH')
		type_G = 'Chebyshev';
	elseif (type_S == 'GP')
		type_G = 'Gauss-Patterson';

	else
		'Error'
		return	
	end	 

	% Options	
	options = spset('NumberOfOutputs',Nd,'FunctionArgType', 'vector',...
	'MinDepth',depth,'MaxDepth',depth,'GridType',type_G,'SparseIndices',Sparse);%,'DropTol',[0.001,0]);
	
	% Object with parameters
	z = spvals(fun,N_th,[lbnd,ubnd],options);
	
end
