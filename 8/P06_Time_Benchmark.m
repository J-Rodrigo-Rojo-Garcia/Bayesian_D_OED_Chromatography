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
% This is the Benchmark for compare the time between the Forward Mapping
% with
% 1) Matlab
% 2) Fortran
% 3) Surrogated (Not yet)


% 1) Reading the parameters
data = load('matlab_data/Structure_Model.mat');
Numeric = data.Numeric; Model = data.Model;

F = Model.F; Nc = Model.Nc; eta = Model.eta;
Ny = Numeric.Ny; dy = Numeric.dy; d_tao = Numeric.d_tao; N_tao = Numeric.N_tao;
Nt_d = Numeric.Nt_d; tao = Numeric.tao; tao_dat = Numeric.tao_dat; In = Numeric.In;  
Nd = Numeric.Nd; 

% 2) Uncertainty parameters
theta = [0.05,0.1,10,70]';

% 3) Design parameters
d = [3,10]';

% 4) Size of the Benchmark
M = 100;
Time = zeros(M,2);
T = 0.0;
cI1 = zeros(Nd,1);
cI2 = zeros(Nd,1);

% 5) Construct the function
FM = @(Theta,D) Forward_Mapping(D(1),Theta(3),Theta(1:2),D(2),Theta(4),...
F,Nc,Ny,dy,tao,d_tao,N_tao,eta,tao_dat,In,Nt_d);

% 5) Benchmark
dire = pwd;
filename = join([dire,'/FM_time.out']);
for k = 1:M
	
	% a) Fortran version
	tic
	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	system(filename);

	% Reading results
	cI1 = load('results/forward_mapping_evaluation/cI.dat');
	T = toc;
	
	% Save time
	Time(k,1) = T;	
	
	% b) Matlab version
	tic
	% Reading results
	cI2 = FM(theta,d);
	T = toc;
	% Save time
	Time(k,2) = T;		
		
	
end

% 6) Plots
dire = 'results/time/';
plots_time(Time,dire)


