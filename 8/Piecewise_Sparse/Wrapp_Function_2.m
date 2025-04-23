function varargout = Wrapp_Function_2(x,MdlKDT,F,Nd)

	% Location of the minimum difference
	k = knnsearch(MdlKDT,x);	
		
	% Sanity check
%	if(r < 0.0000001)
		% Evaluation
		for m = 1:Nd
			varargout{m} = F(k,m);
		end 
%	else
%		'Warning in tolerance, the vector for evaluation could not be into the Smolyak Grid'
%	end

end
