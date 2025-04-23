function [ip, ipder] = interp_NB(z,y,Nd,M)

% Grid parameters
gridtype = z.gridType;
d = z.d;
range = z.range;

vals = z.vals;
n = size(vals,2)

n = size(vals,2) - 1;
nfrom = 0;

%ipmethod = @spinterpnb;
			
% One sample case
%y = y(:)';
pd = [];

% Reescaling
for k = 1:d			
	y(:,k) = (y(:,k)-range(k,1))/(range(k,2)-range(k,1)); 
end
	
ip = zeros(M,Nd);

for k = nfrom:n
	% Get the sequence of levels
	levelseq = spgetseq(k,d);
    for ii = 1:Nd
	    ip(:,ii) = ip(:,ii) + interp_NBO(d,vals{ii,k+1},y,levelseq,pd,M);
	end
	
end

end
