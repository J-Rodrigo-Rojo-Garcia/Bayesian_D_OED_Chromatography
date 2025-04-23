function [X1,X2,U] = grid_to_mesh(x,u)

	% Dimensions
	[Nt,dim_X] = size(x);
	
	% Unique axis
	y = {}; N = 1:dim_X;
	for k = 1:dim_X
		y{k} = unique(x(:,k));
		N(k) = length(y{k});
	end 
	
	% Meshgrid
	[X1,X2] = meshgrid(y{1},y{2});
	U = X1;

	% Look for the elements
	count = 0;
	for ii = 1:N(2)
		for jj = 1:N(1)
			count = count + 1;
			U(jj,ii) = u(count); 	
		end
	end	

end
