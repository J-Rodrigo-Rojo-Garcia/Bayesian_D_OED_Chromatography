function F = Parallel_Evaluations(fun,X,N,Nd)

	% Allocate
	F = zeros(N,Nd);

	% Parallel Evaluations
	parfor (k = 1:N, 40)
		F(k,:) = fun(X(k,:));
	end

end
