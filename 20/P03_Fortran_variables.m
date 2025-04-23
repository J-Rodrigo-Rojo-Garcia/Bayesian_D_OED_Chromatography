clear all
close all
clc

addpath 'OED'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This script reads the variables written in MATLAB and it rewrittes 
% them in data files for readability in Fortran 90,95 and later
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 			General structure of Forward Mapping						%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
data_struct = load('matlab_data/Structure_Model.mat');
Model = data_struct.Model;
Numeric = data_struct.Numeric;
Inversion = data_struct.Inversion;
Noise = data_struct.Noise;
Prior = data_struct.Prior;

% Directory
dire = 'fortran_data/';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed parameters of the model
Nc = Model.Nc; tao_inj = Model.tao_inj; N_th = Model.N_th; F = Model.F;
N_OED = Model.N_OED; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discretization

Ny = Numeric.Ny; dy = Numeric.dy; d_tao = Numeric.d_tao; In = Numeric.In;
N_tao = Numeric.N_tao; tao = Numeric.tao; Nt_d = Numeric.Nt_d; 
Nd = Numeric.Nd; tao_dat = Numeric.tao_dat; Lag = Numeric.Lag;

% Save in txt
save('fortran_data/tao.dat','tao','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uncertainty variables
theta = Inversion.Theta;

% Save in txt
save('fortran_data/theta.dat','theta','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prior intervals
lbnd_th = Prior.lbnd_theta; ubnd_th = Prior.ubnd_theta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Design variables
d = Inversion.D;

% Save in txt
save('fortran_data/d.dat','d','-ascii')

lbnd_d = Prior.lbnd_d; ubnd_d = Prior.ubnd_d;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gaussian Noise
Sigma = Noise.Sigma; Sigma2 = Noise.Sigma2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Variable declaration
Var_FM = [tao_inj;F;Ny;N_tao;dy;d_tao;Nc;Nt_d;Nd;N_th;N_OED];
Var_Inversion = [Sigma;Sigma2];
Var_Bounds_theta = [lbnd_th,ubnd_th];
Var_Bounds_d = [lbnd_d,ubnd_d];
Var_Bounds = [Var_Bounds_theta;Var_Bounds_d];
Var_Nodes_FM = [In,tao_dat,Lag];

% Save in txt
save('fortran_data/var_fm.dat','Var_FM','-ascii')
save('fortran_data/var_inversion.dat','Var_Inversion','-ascii')
save('fortran_data/var_bounds_theta.dat','Var_Bounds_theta','-ascii')
save('fortran_data/var_bounds_d.dat','Var_Bounds_d','-ascii')
save('fortran_data/var_bounds.dat','Var_Bounds','-ascii')
save('fortran_data/var_nodes_fm.dat','Var_Nodes_FM','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 						Smolyak variables								%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case individual

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
Grids = load('matlab_data/Grids_dim.mat');
dim = Grids.dim;
depth = Grids.depth;
type_S = Grids.type_S;
Sparse = Grids.Sparse;
Depth = length(depth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smolyak nodes
N = zeros(Depth,1);
filenames = {};
for k = 1:Depth

	% Read Smolyak nodes
	X = Grids.X{depth(k)};
	N(k) = length(X);
	
	% Save it
	filename = join([dire,'grid_smolyak_',int2str(k),'.dat']);
	save(filename,'X','-ascii')	

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General Smolyak paramaters
save('fortran_data/general_smolyak.dat','dim','Depth','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smolyak depths
Var_Smolyak = [depth',N];
save('fortran_data/depth_smolyak.dat','Var_Smolyak','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case total

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
Grids = load('matlab_data/Grids_dim_tot.mat');
dim = Grids.dim;
depth = Grids.depth;
type_S = Grids.type_S;
Sparse = Grids.Sparse;
Depth = length(depth);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smolyak nodes
N = zeros(Depth,1);
filenames = {};
for k = 1:Depth

	% Read Smolyak nodes
	X = Grids.X{depth(k)};
	N(k) = length(X);
	
	% Save it
	filename = join([dire,'grid_smolyak_tot_',int2str(k),'.dat']);
	save(filename,'X','-ascii')	

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% General Smolyak paramaters
save('fortran_data/general_smolyak_tot.dat','dim','Depth','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smolyak depths
Var_Smolyak = [depth',N];
save('fortran_data/depth_smolyak_tot.dat','Var_Smolyak','-ascii')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 						  OED parameters 								%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% OED parameters

% Design training
Nk = 14;
N_d_OED = Nk*Nk;
Lbnd = lbnd_d';
Ubnd = ubnd_d';
d0 = N_grid(Lbnd,Ubnd,[Nk;Nk]);

% Design simulation points
N_OED_2 = 25;
%N_OED_2 = 24;
%d1 = N_grid([0.1;6.0],[2.8;14],[5;5]);
d1 = zeros(24,2); temp = [1;5;9;13];
d1(1:4,1) = 0.1; d1(1:4,2) = temp;
d1(5:8,1) = 0.5; d1(5:8,2) = temp;
d1(9:12,1) = 1.25; d1(9:12,2) = temp;
d1(13:16,1) = 1.6; d1(13:16,2) = temp;
d1(17:20,1) = 2.6; d1(17:20,2) = temp;
d1(21:24,1) = 3; d1(21:24,2) = temp;  
d1(25,1) = 1; d1(25,2) = 13;

% Prior sample
N_Theta = 10000;
Theta_prior = rand(N_Theta,N_th);
for k = 1:N_th
	Theta_prior(:,k) = lbnd_th(k) + (ubnd_th(k) - lbnd_th(k))*Theta_prior(:,k);
end 

% Grids for training
save('fortran_data/n_grids_training.dat','N_Theta','N_d_OED','N_OED_2','-ascii')

% Save prior sample
save('fortran_data/theta_sample.dat','Theta_prior','-ascii')

% Save d grid
save('fortran_data/design_space.dat','d0','-ascii')

% Grid for MCMCM
save('fortran_data/d_mcmc.dat','d1','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 						  Filenames	     								%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Smolyak nodes total training
name = {};
for k = 1:Depth
	name{k,1} = join(['fortran_data/grid_smolyak_tot_',int2str(depth(k)),'.dat']);	
end
writecell(name,'fortran_data/smolyak_tot_names.dat')

% Smolyak nodes individual training
name = {};
for k = 1:Depth
	name{k,1} = join(['fortran_data/grid_smolyak_',int2str(depth(k)),'.dat']);	
end
writecell(name,'fortran_data/smolyak_names.dat')

% Total training
name = {};
filename = 'results/surrogated_model_tot/training_smolyak_tot_';
for k = 1:Depth
	name{k,1} = join([filename,int2str(depth(k)),'.dat']);	
end
writecell(name,'fortran_data/training_tot_names.dat')

% Individual training
name = {};
filename_2 = {};
dire_path = pwd;
for k = 1:Depth
	% Create the directory for save the individual training
	dire = join([dire_path,'/results/surrogated_model_ind/depth_',int2str(depth(k))]);
	if ~exist(dire, 'dir')
       mkdir(dire)
    end
    % Create the names of the data-files
    dire_rel = join(['results/surrogated_model_ind/depth_',int2str(depth(k))]);
	for l = 1:N_d_OED
		name{l,1} = join([dire_rel,'/training_smolyak_depth_',int2str(l),'.dat']);	
	end
	% The name of the file that conatins the previous names
	filename = join(['fortran_data/training_names_depth_',int2str(depth(k)),'.dat']);
	writecell(name,filename)
	% This last name is saved in a data file
	filename_2{k,1} = filename;
	writecell(filename_2,'fortran_data/training_names.dat')
end

% Design Point names
name = {'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';...
        'R';'S';'T';'U';'V';'W';'X';'Y'};
writecell(name,'fortran_data/design_points_names.dat')

% Create directories for true MCMC simulation and copy it copies the Fortran code
filename_2 = {};
for k = 1:N_OED_2

	% Create directories
	aux = name{k};
	dire = join([dire_path,'/results/mcmc_samples/',aux]);
	if ~exist(dire, 'dir')
       mkdir(dire)
    end

	% Construct the relative directory
    dire_rel = join(['results/mcmc_samples/',aux]);

	% Copy all scalar variables to the directory (with different name)
	filename = 'fortran_data/var_fm.dat';
	R = load(filename);
	filename = join([dire_rel,'/var_fm_',aux,'.dat']);
	save(filename,'R','-ascii')

	% Copy all vectorial variables to the directory
	filename = 'fortran_data/var_nodes_fm.dat';
	R = load(filename);
	filename = join([dire_rel,'/var_nodes_fm_',aux,'.dat']);
	save(filename,'R','-ascii')

	% Copy all vectorial variables to the directory
	filename = 'FM_mcmc.out';
	copyfile(filename,dire_rel)
		
end

% MCMC - Names of nodes for individual training
name = {};
filename_2 = {};
dire_path = pwd;
for k = 1:Depth
    % Create the names of the data-files
    dire_rel = join(['results/surrogated_model_ind/depth_',int2str(depth(k))]);
	for l = 1:N_OED_2
		name{l,1} = join([dire_rel,'/training_mcmc_smolyak_depth_',int2str(l),'.dat']);	
	end
	% The name of the file that conatins the previous names
	filename = join(['fortran_data/training_mcmc_names_depth_',int2str(depth(k)),'.dat']);
	writecell(name,filename)
	% This last name is saved in a data file
	filename_2{k,1} = filename;
	writecell(filename_2,'fortran_data/training_mcmc_names.dat')
end


