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
% True Forward Mapping. Here the utility function is ploted and also the 
% design points are indicated in the plot

% Run the executable
data = load('matlab_data/Structure_Model.mat');
Model = data.Model; 
Prior = data.Prior;
N_OED = Model.N_OED;
lbnd_d = Prior.lbnd_d; ubnd_d = Prior.ubnd_d; 

% 2) Read Design space
d0 = load('fortran_data/design_space.dat');
d1 = load('fortran_data/d_mcmc.dat');

% 3) Read the values
% Read result
U = load('results/oed/U_true.dat');
E = [d0,U];
limits = [0.5,9.2];

% 4) Plot
dire = 'results/oed/';
Name = 'Utility_True';
Title = 'True';
plots_OED_Experiments_2D(E,dire,Name,Title,d0,d1,limits)

file_name = 'results/oed/utility_8_points.pdf';
Axis = 0; Colorb = 1;
plots_OED_2D(E,file_name,Title,d0,d1,limits,Axis,Colorb,1)





