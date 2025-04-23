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

% 1) Reading the parameters
data = load('matlab_data/Structure_Model.mat');
Numeric = data.Numeric; Model = data.Model;
tao = Numeric.tao; tao_dat = Numeric.tao_dat; Nt_d = Numeric.Nt_d; Nc = Model.Nc;

% 3) Design nodes for sampling
d1 = load('fortran_data/d_mcmc.dat');
N_OED_1 = length(d1);

% 4) Read the absolute directory
dire = pwd;

% 5) Names of design nodes
Data = importdata('fortran_data/design_points_names.dat');

% 6) Depths
data = load('matlab_data/Grids_dim.mat');
depth = data.depth; 
Depth_max = 7; % length(depth);

% Samples
cI_tot = {};
cI_ind = cI_tot;
for m = 1:N_OED_1
	'Design index'
	m
 
	% Loading data
	aux = Data{m};
	dire_2 = join(['results/mcmc_samples/',aux]);
	filename = join([dire_2,'/data_',aux,'.dat']);
	data = load(filename); data = reshape(data,[Nt_d,Nc]); 

	% Loading the solution to the PDE
	filename = join([dire_2,'/c_true_',aux,'.dat']);
	c = load(filename);

	% Loading evaluation in the true parameter
	filename = join([dire_2,'/cI_true_',aux,'.dat']);
	cI = load(filename); cI = reshape(cI,[Nt_d,Nc]);
	
	% Load the surrogated evaluations 
%	for k = 1:Depth_max
	for k = 4:4	
		% Depth
		'Depth'
		depth(k)

%		% Total version
%		filename = join([dire_2,'/c_tot_depth_',int2str(k),'_',aux,'.dat']);
%		ck = load(filename);
%		cI_tot{k} = reshape(ck,[Nt_d,Nc]);
		
		% Individual version
		filename = join([dire_2,'/c_ind_depth_',int2str(k),'_',aux,'.dat']);
		ck = load(filename);
		cI_ind{k} = reshape(ck,[Nt_d,Nc]);

	end

	% Plots
	
	% - Total version
%	name = join(['/eval_tot_',aux]);
%	Title = join(['True vs Surrogated (total). Point ',aux])
%	plots_data(tao_dat,tao,c,cI,cI_tot,data,depth,Depth_max,Nc,dire_2,name,Title)

	% - Individual version
	name = join(['/eval_ind_',aux]);
	Title = join(['True vs Surrogated (individual). Point ',aux])
	plots_data(tao_dat,tao,c,cI,cI_ind,data,depth,5,Nc,dire_2,name,Title)
	
end


