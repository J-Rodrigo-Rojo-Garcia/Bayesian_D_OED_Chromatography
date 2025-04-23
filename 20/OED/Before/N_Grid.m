%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number of nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function X = N_Grid(N,lbnd,ubnd,dim_X)
	
	% Size
	Nt = prod(N);
	
	% Allocate
	X = zeros(Nt,dim_X);
	
	% Begin
	for ii = 1:dim_X
		Axis = linspace(lbnd(ii),ubnd(ii),N(ii));
		k = Nt/prod(N(ii:dim_X));
		
		for jj = 1:N(ii)
			index_0 = 1 + (jj-1)*k;
			index_f = jj * k;
			X(index_0:index_f,ii) = Axis(jj);
		end
		
		p = prod(N(1:ii));
		k = Nt/p;
		
		for jj = 1:k
			index_0 = 1 + (jj-1)*p;
			index_f = jj*p;
			X(index_0:index_f,ii) = X(1:p,ii);
		end
		
	end		
		    
end

