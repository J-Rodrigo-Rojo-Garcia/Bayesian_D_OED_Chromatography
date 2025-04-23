clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the directories

%addpath 'Forward_Mapping'
%addpath 'Inversion'
%addpath 'MCMC'
%addpath 'OED'
%addpath 'Piecewise_Sparse'
%addpath 'Plots'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Design points

filename = 'fortran_data/design_space.dat';
d = load(filename);
filename = 'fortran_data/design_space.txt';
save(filename,'d','-ascii')

filename = 'fortran_data/d_mcmc.dat';
d_mcmc = load(filename);
filename = 'fortran_data/d_mcmc.txt';
save(filename,'d_mcmc','-ascii')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utilities

filename = 'results/oed/OED_surr_ind_5.dat';
Us_20 = load(filename);
Us_20 = Us_20(:,3);
filename = 'results/oed/Us_20.txt';
save(filename,'Us_20','-ascii')

filename = 'results/oed/U_true.dat';
U_20 = load(filename);
filename = 'results/oed/U_20.txt';
save(filename,'U_20','-ascii')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Forward Mapping Evaluations

P = {'L','M','N','P','R','T','X','Y'};

% Read data
for k = 1:1
	% Nodes
	dir1 = 'results/mcmc_samples/';

	for l = 1:8
		% Directory
		dir2 = [dir1,P{l},'/'];
		% PDE solution
		filename = [dir2,'c_true_',P{l},'.dat'];
		data = load(filename);
		filename = [dir2,'c_true_',P{l},'.txt'];
		save(filename,'data','-ascii')
		% Data
		filename = [dir2,'data_',P{l},'.dat'];
		data = load(filename);
		filename = [dir2,'data_',P{l},'.txt'];
		save(filename,'data','-ascii')
		% Surrogate model
		filename = [dir2,'c_ind_depth_5_',P{l},'.dat'];
		data = load(filename);
		filename = [dir2,'c_ind_depth_5_',P{l},'.txt'];
		save(filename,'data','-ascii')
	end
	% Times
	filename = ['matlab_data/Structure_Model.mat'];
	data = load(filename);
	data = data.Numeric;
	tau = data.tao;
	tau_data = data.tao_dat;
	filename = [dir1,'tau.txt'];
	save(filename,'tau','-ascii')
	filename = [dir1,'tau_data.txt'];
	save(filename,'tau_data','-ascii')
end		

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Samples

% Read data
for k = 1:1
	% Nodes
	dir1 = 'results/mcmc_samples/';
	for l = 1:8
		% Directory
		dir2 = [dir1,'/',P{l},'/'];
		% Theta post
		filename = [dir2,'theta_post.dat'];
		data = load(filename);
		filename = [dir2,'theta_post.txt'];
		save(filename,'data','-ascii')
		% Theta post surrogate
		filename = [dir2,'theta_post_surr_ind_depth_5.dat'];
		data = load(filename);
		filename = [dir2,'theta_post_surr.txt'];
		save(filename,'data','-ascii')
	end
end		

