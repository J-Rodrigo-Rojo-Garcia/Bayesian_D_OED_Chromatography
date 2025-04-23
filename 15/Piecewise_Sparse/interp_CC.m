function ip = interp_CC(z,y,Nd,M)
	
% Grid parameters
gridtype = z.gridType;
d = z.d;
range = z.range;

sparseIndices = 'on';
indices = z.indices;

vals = z.vals;

%ipmethod = @spinterpccsp;

% One sample case
%y = y(:)';
pd = [];

% Reescaling
for k = 1:d			
	y(:,k) = (y(:,k)-range(k,1))/(range(k,2)-range(k,1)); 

%(y - ones(size(y,1),1)*range(:,1)') ./ ...
%	(ones(size(y,1),1)*(range(:,2)'-range(:,1)'));
end

% Allocate	
ip = zeros(M,Nd);
%	if isfield(z, 'purgeData')
%		pd = z.purgeData(:,output);
%	else
%		pd = [];
%	end
for k = 1:Nd
%	ip(k) = feval(ipmethod,d,vals{k},y,indices,pd);
	ip(:,k) = interp_CC_sparse(d,vals{k},y,indices,pd,M);
%	ip(k) = spinterpccsp(d,vals{k},y,indices,pd);
end

end
