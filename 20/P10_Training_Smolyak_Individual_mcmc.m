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
% This subroutine runs the training evaluations using the Smolyak nodes
'Training_Smolyak_Individual_mcmc'

% 1) Read parameters

% Number of outputs of FM
data = load('matlab_data/Structure_Model.mat');
Nd = data.Numeric.Nd;

% Parameters for Surrogated Model
data = load('matlab_data/Grids_dim.mat');
lbnd = data.lbnd; ubnd = data.ubnd;
depth = data.depth; Depth_max = length(depth);
type_S = data.type_S; Sparse = data.Sparse; Grid = 'on';
X = data.X;

% Total number of depths
data = load('fortran_data/general_smolyak.dat');
Dim = round(data(1));
Depth_max = round(data(2));

% Number of nodes for Smolyak grid
data = load('fortran_data/depth_smolyak.dat');
N = round(data(:,2));

% Number of nodes in Design Space
data = load('fortran_data/n_grids_training.dat');
N_OED_T = round(data(3));

% 2) Read the absolute directory
dire = pwd;

% 3) Begin training
for k = 5:5

	'k = '
	k

	% a) Save the temporal depth
	save('results/surrogated_model_ind/temporal_index.dat','k','-ascii')

	% b) Run the executable
	filename = join([dire,'/training_mcmc_individual.out']);
	system(filename);

	% c) Training process
	Xk = X{k};

	% d) Previous name of the directory and name of the files 
	name = join(['results/surrogated_model_ind/depth_',int2str(k)]);
	name = join([name,'/training_mcmc_smolyak_depth_']);
	
	% e) Space in mmeory for the data
	F = {};
	Z = {};		

	% f) Read-Destruction-Training	
	%for l = 1:N_OED_T
	for l = 25:25
			
		% Final name of data files
		filename = join([name,int2str(l),'.dat']);

		% Reading evaluations
		Fk = load(filename);
		
		% Save in memory data files
		F{k} = Fk;
		
		% Erase the datafiles (OPTIONAL)
		delete(filename);

		% Function for wrapping
		fun = @(x) Wrapp_Function(x,Xk,Fk,Nd);

		% Training
		z = training_process_vect(fun,Dim,Nd,lbnd,ubnd,depth(k),type_S,Sparse,Grid);
		Z{l} = z;

	end

	% g) Save the evaluations
	dire_2 = join(['results/surrogated_model_ind/depth_',int2str(k)]);
	filename = join([dire_2,'/Fk_mcmc_Eval_depth_',int2str(k),'.mat']); 
	save(filename,'F')

	% h) Save the training
	filename = join(['results/surrogated_model_ind/depth_',int2str(k)]);
	filename = join([dire_2,'/PSI_mcmc_depth_',int2str(k),'.mat']); 	 
	save(filename,'Z')


end

