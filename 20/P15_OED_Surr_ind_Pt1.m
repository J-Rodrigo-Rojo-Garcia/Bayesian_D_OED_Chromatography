clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the directories
addpath 'Inversion'
addpath 'OED'
addpath 'Piecewise_Sparse'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program runs the Utility Function for the Surrogated Forward 
% Mapping. It uses the total surrogated model
'P15_OED_Surr_ind_Pt1'

% 1) Read parameters

% Number of outputs of FM
data = load('matlab_data/Structure_Model.mat');
Model = data.Model;
N_th = Model.N_th; N_OED = Model.N_OED; 
Noise = data.Noise;
Nd = data.Numeric.Nd;

% Parameters for Surrogated Model
data = load('matlab_data/Grids_dim.mat');
lbnd = data.lbnd; ubnd = data.ubnd;
depth = data.depth; 
type_S = data.type_S; Sparse = data.Sparse; Grid = 'on';
Depth_max = 7;  %length(depth);

% 2) Design nodes

% Number of nodes in Design Space
data = load('fortran_data/n_grids_training.dat');
N_OED_T = round(data(2));

% Design Nodes
d0 = load('fortran_data/design_space.dat');

% Theta sample
Theta_prior = load('fortran_data/theta_sample.dat');
M = length(Theta_prior);

% 3) OED
E = zeros(N_OED_T,3);

%for k = 5:Depth_max
k = 5;

	'Depth = '
	k

	% Training object
	dire_2 = join(['results/surrogated_model_ind/depth_',int2str(k)]);
	filename = join([dire_2,'/PSI_depth_',int2str(k),'.mat']); 
	Z = load(filename);
	Z = Z.Z;

	parfor m = 1:N_OED_T	
	
		% Surrogated function
		z = Z{m};
		fun = @(theta,d) interp_CC_vect(z,theta,Nd,1);
	
		% Utility function
		Em = OED_E2_parallel(fun,N_th,Nd,lbnd,ubnd,Noise,M,N_OED,Theta_prior,d0(m,:),1);
		E(m,:) = Em;	

	end

	% Save the result
	filename = join(['results/oed/OED_surr_ind_',int2str(depth(k)),'.dat']);
	save(filename,'E','-ascii')

%end
 

