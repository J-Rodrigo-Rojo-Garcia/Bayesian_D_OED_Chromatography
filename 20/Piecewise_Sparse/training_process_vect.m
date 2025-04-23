function z = training_process_vect(fun,N_th,Nd,lbnd,ubnd,depth,type_S,Sparse,Grid)

	% Grid type %
	
	% Clenshaw-Curtis
	if (type_S == 'CC')
		type_G = 'Clenshaw-Curtis';
	% Maximum norm
	elseif (type_S == 'MX')
		type_G = 'Maximum';
	% Maximum norm with no boundary
	elseif (type_S == 'NB')
		type_G = 'NoBoundary';
	% Chebyshev
	elseif (type_S == 'CH')
		type_G = 'Chebyshev';
	% Gauss-Patterson
	elseif (type_S == 'GP')
		type_G = 'Gauss-Patterson';
	else
		'Error'
		return	
	end	 

	% Options	
	options = spset('NumberOfOutputs',Nd,'FunctionArgType', 'vector','KeepGrid',Grid,...
	'MinDepth',depth,'MaxDepth',depth,'GridType',type_G,'SparseIndices',Sparse);

	% Object with parameters (training)
	Z = spvals(fun,N_th,[lbnd,ubnd],options);
	
	% Parameters for surrogated
	z.d = Z.d;
	z.range = Z.range;
	z.lbnd = lbnd(:)';
	z.ubnd = ubnd(:)';
	z.Nw = Z.nPoints;
		
	% Keep Grid
	if (Grid == 'on') 
		z.grid = Z.grid;
	end	

	% Specific parameters
	if (type_S == 'CC')
		% Clenshaw - Curtis
		indices = Z.indices;
		indices.indicesNDims  = double(indices.indicesNDims);
		indices.indicesDims   = double(indices.indicesDims);
		indices.indicesLevs   = double(indices.indicesLevs);
		indices.subGridPoints = double(indices.subGridPoints);
		indices.Levs2 = max(2,2.^(indices.indicesLevs-1));
		z.indices = indices;

		% Vals
		R = zeros(z.Nw,Nd);
		for k = 1:Nd
			R(:,k) = Z.vals{k};
		end
		z.vals = R;

	elseif (type_S == 'NB')
		% Maximum with no boundary
		z.n = size(Z.vals,2) - 1;
		z.nfrom = 0;
				
		% Vals
		z.vals = Z.vals;
		
		% Get the sequence of levels
		for k = z.nfrom:z.n
			levelseq{k+1} = double(spgetseq(k,z.d));
		end
		z.levelseq = levelseq;
		
	end
		
end
