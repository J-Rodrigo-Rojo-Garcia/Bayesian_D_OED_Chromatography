function varargout = Wrapp_Function(x,X,F,Nd)

	% Location of the minimum difference
	W = vecnorm(X - x,2,2);
	[r,k] = min(W);	
	
	% Sanity check
	if (r < 0.0000001)
		% Evaluation
		for m = 1:Nd
			varargout{m} = F(k,m);
		end 
	else
		'Warning in tolerance, the vector for evaluation could not be into the Smolyak Grid'
	end

end
