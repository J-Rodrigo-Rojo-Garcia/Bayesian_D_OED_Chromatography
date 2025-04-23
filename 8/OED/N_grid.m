%%% Parameters collocation %%%

function X = N_grid(Lbnd,Ubnd,N)

	% Axis %
	X_prev = linspace(Lbnd(1),Ubnd(1),N(1))';
	
	% Total of dimensions
	N_dim = length(N); 
	
	% Construct grid
	for k = 2:N_dim

		x = linspace(Lbnd(k),Ubnd(k),N(k));
		[Mx,My] = size(X_prev);
		X = zeros(Mx,My+1);
		for m = 1:N(k)
			X(1 + Mx*(m-1):Mx*m,1:My) = X_prev;
			X(1 + Mx*(m-1):Mx*m,1+My) = x(m);
		end
		X_prev = X;	
		
	end


end

