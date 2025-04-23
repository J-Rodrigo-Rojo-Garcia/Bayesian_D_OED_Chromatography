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
% This script calculates the MCMC process for the true Forward Mapping
'P17_MCMC_Surr_ind_Pt1'

% 1) Read parameters
data = load('matlab_data/Structure_Model.mat');

% Number of nodes
Nd = data.Numeric.Nd;
% Dimensions of unvcertainty an design spaces
N_th = data.Model.N_th; N_OED = data.Model.N_OED;
% Level of noise
Sigma = data.Noise.Sigma; Sigma2 = data.Noise.Sigma2; 

% 2) Prior intervals
data = load('matlab_data/Grids_dim.mat');
lbnd = data.lbnd; ubnd = data.ubnd;
depth = data.depth; 
type_S = data.type_S; Sparse = data.Sparse; Grid = 'on';
Depth_max = length(depth);

% 3) True parameter
Theta_true = [0.05;0.1;10;70];

% 4) Design nodes for sampling
d1 = load('fortran_data/d_mcmc.dat');
N_OED_1 = length(d1);

% 5) Read the absolute directory
dire = pwd;

% 6) Time process
Time_MCMC = zeros(N_OED_1,1);

% 7) Names of design nodes
Data = importdata('fortran_data/design_points_names.dat');

% 8) Number of simulations
M = 80000; 

% 9) MCMC Simulation
%for k = 1:7
k = 5;

	'Depth = '
	k

	% Training object
	dire_2 = join(['results/surrogated_model_ind/depth_',int2str(k)]);
	filename = join([dire_2,'/PSI_mcmc_depth_',int2str(k),'.mat']); 
	Z = load(filename);
	Z = Z.Z;

	% Samples
	%parfor m = 1:N_OED_1
	for m = 25:25

		% Loading data
		aux = Data{m};
		dire_2 = join(['results/mcmc_samples/',aux]);
		filename = join([dire_2,'/data_',aux,'.dat']);
		data = load(filename);

		% Surrogated function
		dm = d1(m,:);
		z = Z{m};
		FM = @(theta) interp_CC_vect(z,theta,Nd,1)';

		% Temporal directory
		abs_dir = join([dire,'/',dire_2]);
		
		% Evaluation in the true parameter
		filename = join([abs_dir,'/c_ind_depth_',int2str(k),'_',aux,'.dat']);
		ck = FM(Theta_true');
		my_save_mcmc(filename,ck)
	
		% Sample MCMC
		theta_post = inv_prob_sample(FM,N_th,data,Nd,Sigma2,M,lbnd,ubnd);
		filename = join([abs_dir,'/theta_post_surr_ind_depth_',int2str(k),'.dat']);
		my_save_mcmc(filename,theta_post)

	end

%end

