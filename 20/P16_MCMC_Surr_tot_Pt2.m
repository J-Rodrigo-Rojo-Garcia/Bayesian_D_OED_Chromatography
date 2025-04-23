clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the directories
addpath 'Forward_Mapping'
addpath 'Inversion'
addpath 'MCMC'
addpath 'OED'
addpath 'Piecewise_Sparse'
addpath 'Plots'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script plots the samples calculated in the design points with the
% true FM

% 1) Read parameters
data = load('matlab_data/Structure_Model.mat');

% 2) Dimensions of uncertainty an design spaces
N_th = data.Model.N_th; N_OED = data.Model.N_OED;

% 3) Prior intervals
data = load('matlab_data/Grids_dim_tot.mat');
lbnd = data.lbnd; ubnd = data.ubnd;
depth = data.depth; 
type_S = data.type_S; Sparse = data.Sparse; Grid = 'on';
Depth_max = length(depth);

% 4) True parameter
Theta_true = [0.05;0.1;10;70];

% 5) Design nodes for sampling
d1 = load('fortran_data/d_mcmc.dat');
N_OED_1 = length(d1);

% 6) Read the absolute directory
dire = pwd;

% 7) Names of design nodes
Data = importdata('fortran_data/design_points_names.dat');

% 8) Burnin
burn = 10000;

% 9) Plot
for k = 1:Depth_max

	% Plot parameters
	Title = join(['Surrogated FM (Total) - Depth ',int2str(k)]);
	pre_name = join(['Surr_Tot_Depth_',int2str(k)]);

	for m = 1:N_OED_1

		% Temporal directory
		aux = Data{m};
		dire_2 = join(['results/mcmc_samples/',aux]);
		abs_dir = join([dire,'/',dire_2,'/']);
	
		% Name of the Sample MCMC
		filename = join([abs_dir,'/theta_post_surr_tot_depth_',int2str(k),'.dat']);
		Theta_post = load(filename);

		% Plots
		plots_MCMC(N_th,Theta_true,Theta_post,abs_dir,burn,Title,pre_name,lbnd,ubnd,m)

	end
end
