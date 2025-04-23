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
% This program is the second part of the Utility Function for the 
% Surrogated Forward Mapping. This is the version with the individual 
% variables. Here the utility function is ploted and also the 
% design points are indicated in the plot

% 1) Data

% Parameters for Surrogated Model
data = load('matlab_data/Grids_dim_tot.mat');
depth = data.depth; Depth_max = length(depth);

% 2) Read Design space
d0 = load('fortran_data/design_space.dat');
d1 = load('fortran_data/d_mcmc.dat');
limits = [0.5,9.2];

% 3) Process
Depth_max = 7;
%for k = 1:Depth_max
for k = 5:5

	% Read result
	filename = join(['results/oed/OED_surr_ind_',int2str(depth(k)),'.dat']);
	E = load(filename);

	% Plot
	dire = 'results/oed/';
	Name = join(['Utility_Surr_Ind_depth_',int2str(depth(k))]);
	Title = 'Utility Function - Individual Surrogated FM';
	plots_OED_Experiments_2D(E,dire,Name,Title,d0,d1,limits)

end







