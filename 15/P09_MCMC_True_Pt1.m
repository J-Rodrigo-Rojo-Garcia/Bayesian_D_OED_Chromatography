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
%M = 20000;  

% 10) Pre-process
Filen_exec = {};
Filen_th = {};
Filen_res = {};
Filen_d = {};
Last_dir = {};
Execution = {};

'Simulated data'

for k = 25:25
%for k = 1:N_OED_1

	'k = '
	k

	% Temporal directory
	aux = Data{k};
	dire_2 = join(['results/mcmc_samples/',aux]);
	abs_dir = join([dire,'/',dire_2]);

	% Save the temporal true uncertainty parameter
	filename = join([dire_2,'/theta_true_',aux,'.dat']);	
	save(filename,'Theta_true','-ascii')

	% Save the design parameter
	d = d1(k,:)';
	filen_d = join([abs_dir,'/d_',aux,'.dat']);
	Filen_d{k} = filen_d;	
	save(filen_d,'d','-ascii')

	% Directories
	Last_dir{k} = aux; 
	filen_exec = join([abs_dir,'/FM_mcmc.out']);	
	Filen_exec{k} = filen_exec;
	filen_th = join([abs_dir,'/theta_',aux,'.dat']);
	Filen_th{k} = filen_th;
	filen_res = join([abs_dir,'/cI_',aux,'.dat']);
	Filen_res{k} = filen_res;
	
	% Order for execution
	execution = sprintf(['echo ',aux]);
	execution = sprintf([execution,' ','|',' ' ,filen_exec]);

	% Solution to the PDE

	% - Save the parameters for evaluation
	save('results/forward_mapping_evaluation/theta.dat','Theta_true','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')
	% - Name of tthe executable
	filename = join([dire,'/FM.out']);
	% - Run executable
	system(filename);
	% - Load and save the results
	c = load('results/forward_mapping_evaluation/c.dat');
	filename = join([dire_2,'/c_true_',aux,'.dat']);
	save(filename,'c','-ascii')
	
	cI = load('results/forward_mapping_evaluation/cI.dat');
	Nr = round(length(cI)/2);
	cI = reshape(cI,[Nr,2]);
	filename = join([dire_2,'/cI_true_',aux,'.dat']);
	save(filename,'cI','-ascii')

	% Construct FM 
	FM =@(Theta) FM_Wrapp_MCMC(Theta,d,execution,filen_th,filen_d,filen_res);	
	
	% Simulate the FM
	cI = FM(Theta_true);
	
	% Add noise (artificial data)
	data = cI + Sigma*randn(size(cI));
	filename = join([dire_2,'/data_',aux,'.dat']);
	save(filename,'data','-ascii')

end
clc

'MCMC true process'

% Simulation
for k = 25:25
%parfor k = 1:N_OED_1

	% Design parameter
	d = d1(k,:)';

	% Forward Mapping
	filen_exec = Filen_exec{k};
	filen_th = Filen_th{k};
	filen_res = Filen_res{k};
	filen_d = Filen_d{k};
	last_dir = Last_dir{k};	

	% Order for execution
	execution = sprintf(['echo ',last_dir]);
	execution = sprintf([execution,' ','|',' ' ,filen_exec]);

	% Construct FM 
	FM =@(Theta) FM_Wrapp_MCMC(Theta,d,execution,filen_th,filen_d,filen_res);	

	% Temporal directory
	aux = Data{k};
	dire_2 = join(['results/mcmc_samples/',aux]);
	abs_dir = join([dire,'/',dire_2]);
	filename = join([dire_2,'/data_',aux,'.dat']);
	data = load(filename);
	
	% Sample MCMC
	theta_post = inv_prob_sample(FM,N_th,data,Nd,Sigma2,M,lbnd,ubnd);
	filename = join([abs_dir,'/theta_post.dat']);
	my_save_mcmc(filename,theta_post)

end

