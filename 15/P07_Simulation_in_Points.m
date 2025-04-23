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
% This subroutine runs the Forward Mapping made in Fortran for the design 
% points. The reason is compare the behavior with respect to the design
% variables.
% Remark: The evaluation is respect to the true parameter.

% 1) Reading the parameters
data = load('matlab_data/Structure_Model.mat');
Numeric = data.Numeric; Model = data.Model;
tao = Numeric.tao; tao_dat = Numeric.tao_dat; Nt_d = Numeric.Nt_d; Nc = Model.Nc;

% 2) Uncertainty parameters
theta = [0.05,0.1,10,70]';
save('fortran_data/theta.dat','theta','-ascii')

% 3) Design parameters for simulation
d1 = load('fortran_data/d_mcmc.dat');

% 4) Simulate in the design points

% Name for saving
names = importdata('fortran_data/design_points_names.dat');

% Executable directory
dire = pwd;
filename = join([dire,'/FM.out']);

% Simulation
for k = 1:25
%for k = 1:24

	% Design point
	d = d1(k,:)';
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Directory for design points
	r = names(k,:); r = r{1};
	dire_MCMC = join(['results/mcmc_samples/',r,'/']);

	% Plots
	filename_2 = join(['FM_',r]);
	Title = join(['Forward Mapping. Point ',r]);
	plots_FM(tao_dat,tao,c,cI,Nc,dire_MCMC,filename_2,Title)

end


