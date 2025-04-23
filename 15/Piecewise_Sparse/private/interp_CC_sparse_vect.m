function ip = interp_CC_sparse_vect(d,z,y,seq,ninterp,Nd)
% SPINTERPCCSP  Multi-linear interpol. (Clenshaw-Curtis, sparse ids)
%    IP = SPINTERPCC(D,Z,Y,SEQ)  Computes the interpolated
%    values at [Y1, ..., YN] over the sparse grid for the given
%    sequence of index sets SEQ. This routine does essentially
%    the same as SPINTERPCC, but operates over sparse index sets
%    for increased efficiency, especially in case of higher
%    dimensions D. (Internal function)
%
% See also SPINTERPCC.

% Author : Andreas Klimke, Universitaet Stuttgart
% Version: 1.1
% Date   : February 3, 2006

% Change log:
% V1.0   : Mar 09, 2005
%          Initial release.
% V1.1   : February 3, 2006
%          Added droptol processing.
	
% ------------------------------------------------------------
% Sparse Grid Interpolation Toolbox
% Copyright (c) 2006 W. Andreas Klimke, Universitaet Stuttgart 
% Copyright (c) 2007-2008 W. A. Klimke. All Rights Reserved.
% See LICENSE.txt for license. 
% email: klimkeas@ians.uni-stuttgart.de
% web  : http://www.ians.uni-stuttgart.de/spinterp
% ------------------------------------------------------------

% Initial values
ip = zeros(ninterp,Nd);

% The multi-index information is stored in an internal sparse
% format. The format is as follows. Consider the following sequence
% of indices, stored as full array:
%     2     0     0       nnz = 1
%     1     1     0             2
%     0     2     0             1
%     1     0     1             2
%     0     1     1             2
%     0     0     2             1
% In sparse format, this becomes:
% NDims = 1    Dims = 1   Levs = 2
%         2           1          1
%         1           2          1
%         2           2          2
%         2           1          1
%         1           3          1
%                     2          1
%                     3          1
%                     3          2

%indicesNDims  = double(seq.indicesNDims);
%indicesDims   = double(seq.indicesDims);
%indicesLevs   = double(seq.indicesLevs);
%subGridPoints = double(seq.subGridPoints);
%Levs2 = max(2,2.^(indicesLevs-1));

indicesNDims  = seq.indicesNDims;
indicesDims   = seq.indicesDims;
indicesLevs   = seq.indicesLevs;
subGridPoints = seq.subGridPoints;
Levs2 = seq.Levs2;


% Get the number of levels
nlevels = length(indicesNDims);
	
% index contains the index of the resulting array containing all
% subdomains of the level.
		
index2 = zeros(d,1); 
repvec = ones(d,1);
level  = ones(d,1);
dimvec = zeros(d,1);
	
% currentindex is the index of the currently processed multiindex
% entry. 
addr = 1;

% Case ndmis == 0
ip = ip + z(1,:);
index = 2;

% Case ndims > 0
for currentindex = 2:nlevels
	
%	npoints = 1;
	ndims = indicesNDims(currentindex);
	
%	did = 1;
%	while did <= ndims
	for did = 1:ndims
		dimvec(did) = indicesDims(addr);
%		lval = indicesLevs(addr);
%		level(did) = lval;
		level(did) = indicesLevs(addr);
		npoints = subGridPoints(currentindex);
%		if lval < 3
%			repvec(did) = 2;
%		else
%			repvec(did) = 2^(lval-1);
%		end
		repvec(did) = Levs2(addr);
		if did > 1
			repvec(did) = repvec(did) * repvec(did-1);
		end
		addr = addr + 1;
%		did = did + 1;
	end
%	yt = 0;
		
	for k = 1:ninterp
		temp = 1;
		for did = 1:ndims
			lval = level(did);
			yt = y(k,dimvec(did));
							
			% Compute the scaling factor and the array position of
			% the weight
			if lval == 1
				temp = temp * abs(1 - 2*yt);
				index2(did) = min(1,floor(2*yt));
%				if yt == 1
%					index2(did) = 1;
%				else
%					xp = floor(yt * 2);
%					if xp == 0
%						temp = temp * 2 * (0.5 - yt);
%					else
%						temp = temp * 2 * (yt - 0.5);
%					end
%					index2(did) = xp;
%				end
				
			elseif yt == 1
				temp = 0;
				break;
			else
				scale = 2^lval;
				xp = floor(yt * scale / 2);
				temp = temp * ...
							 (1 - scale * abs( yt - ( (xp*2+1)/scale )));
				index2(did) = xp;
			end
		end
			
		index3 = index + index2(1);
		for did = 2:ndims
			index3 = index3 + repvec(did-1)*index2(did);
		end
		ip(k,:) = ip(k,:) + temp*z(index3,:);
	end
	index = index + npoints;

end

