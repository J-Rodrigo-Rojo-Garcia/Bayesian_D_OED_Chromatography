clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the directories
addpath 'Plots'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% True Forward Mapping

% 1) Read Design space
d0 = load('fortran_data/design_space.dat');
d1 = load('fortran_data/d_mcmc.dat');

% 2) Read the values
% Read result
U = load('results/oed/U_true.dat');
E = [d0,U];

% 3) Limits
limits = [min(U),max(U)];
limits = [8.0,9.21];

% 4) Plot
dire = 'results/oed/';
Name = 'Utility_True';
Title = 'U(d) with G';

plots_OED_Experiments_2D(E,dire,Name,Title,d0,d1,limits)

file_name = 'results/oed/utility_20_points.pdf';
Axis = 0; Colorb = 1;
plots_OED_2D(E,file_name,'lalala',d0,d1,limits,Axis,Colorb,1)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Surrogated Forward Mapping (individual plots)

% 1) Data

% Parameters for Surrogated Model
data = load('matlab_data/Grids_dim.mat');
depth = data.depth; Depth_max = length(depth);
X = data.X;

% 2) Process
for k = 1:6

	% Read result
	filename = join(['results/oed/OED_surr_ind_',int2str(depth(k)),'.dat']);
	Es = load(filename);
	
	% Grids
	x = X{k};
	N = length(x);

	% Plot
	dire = 'results/oed/';
	Name = join(['Utility_Surr_20_Depth_',int2str(depth(k))]);
	Title = join(['U_{N}(d) with N = ',int2str(N)]);
%	plots_OED_Experiments_2D(Es,dire,Name,Title,d0,d1,limits)
	
	% Plots V2
	M = 20; Axis = 0; Colorb = 0;
	file_name = join([dire,'utility_',int2str(M),'_points_depth_',int2str(k),'.pdf']);
	plots_OED_2D(Es,file_name,'lalala',d0,d1,limits,Axis,0,1)

	% Plots Error
	M = 20; Axis = 0; Colorb = 1; Title = {0,'Error'};
	file_name = join([dire,'error_',int2str(M),'_points_depth_',int2str(k),'.pdf']);
	Es(:,3) = abs(Es(:,3) - E(:,3));
	limits2 = [min(Es(:,3)),max(Es(:,3))];
	plots_OED_2D(Es,file_name,Title,d0,d1,limits2,Axis,1,0)

end


