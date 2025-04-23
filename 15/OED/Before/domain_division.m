%%% Parameters collocation %%%

% N_th = Dimension of parametral space
% Deg_p = Degree of polynomial
% Dim_p = Dimension of the polynomial space
% Nw = Number of weights
% Nz = Number opar_OED_df nodes in parametral space (a particular case is Nw = Nz for quadrature nodes)
% Nd = Dimension of data

function [DD,N_DD] = domain_division(Delta,par_OED)

	% Dimension
	N_OED = par_OED.N_OED;
	
	% Intervals
	Axis_DD = zeros(N_OED,4);
	Lbnd = zeros(N_OED,3);
	Ubnd = Lbnd;
	Lbnd_DD = Lbnd;
	Ubnd_DD = Lbnd;

	for k = 1:par_OED.N_OED
		Axis_DD(k,:) = linspace(par_OED.lbnd(k),par_OED.ubnd(k),4);
		Lbnd(k,:) = Axis_DD(k,1:3);
		Ubnd(k,:) = Axis_DD(k,2:4);		
		Lbnd_DD(k,:) = Lbnd(k,:) - Delta;
		Ubnd_DD(k,:) = Ubnd(k,:) + Delta;
	end
	
	% Transpose
	Lbnd = transpose(Lbnd);
	Ubnd = transpose(Ubnd);
	Lbnd_DD = transpose(Lbnd_DD);
	Ubnd_DD = transpose(Ubnd_DD);
	
	% Domain division
	N_DD = 3^N_OED;

	% General index
	N = 3*ones(N_OED,1);
	I0 = ones(N_OED,1);
	Ind = N_Grid(N,I0,N,N_OED);
	
	% A grid with for nodes in OED
	lbnd_x = zeros(3,N_OED);
	ubnd_x = zeros(3,N_OED);
	N_x = zeros(3,N_OED);
	for k = 1:N_OED
		x = linspace(par_OED.lbnd(k),par_OED.ubnd(k),par_OED.Nx(k));
		for ii = 1:3
			Index = find(x >= Lbnd(ii,k) & x <= Ubnd(ii,k));
			Min = min(x(Index));
			Max = max(x(Index));
			N_x(ii,k) = length(Index);
			lbnd_x(ii,k) = Min;
			ubnd_x(ii,k) = Max;			
		end	
	end

	% Cell for objects
	DD = {}; 
	par_OED_d.N_OED = N_OED; par_OED_d.NT = prod(prod(N_x));
		

	% Bounds
	lbnd = zeros(N_OED,1); ubnd = lbnd;
	lbnd_d = lbnd; ubnd_d = ubnd; Nx_d = lbnd_d;
	for ii = 1:N_DD
		for jj = 1:N_OED
			lbnd(jj) = Lbnd_DD(Ind(ii,jj),jj);
			ubnd(jj) = Ubnd_DD(Ind(ii,jj),jj);
			lbnd_d(jj) = lbnd_x(Ind(ii,jj),jj);
			ubnd_d(jj) = ubnd_x(Ind(ii,jj),jj);
			Nx_d(jj) = N_x(Ind(ii,jj),jj);
		end
		% Create the object for OED parameters
		par_OED_d.lbnd = lbnd;
		par_OED_d.ubnd = ubnd;
		par_OED_d.grid = N_Grid(Nx_d,lbnd_d,ubnd_d,N_OED);
		DD{ii} = par_OED_d;
	end
	
end

