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
% This subroutine runs perturbation of the parameters (uncertainty and
% design) and plot it

% 1) Reading the parameters
data = load('matlab_data/Structure_Model.mat');
Numeric = data.Numeric; Model = data.Model;
tao = Numeric.tao; tao_dat = Numeric.tao_dat; Nt_d = Numeric.Nt_d; Nc = Model.Nc;
lbnd_theta = data.Prior.lbnd_theta; ubnd_theta = data.Prior.ubnd_theta;
lbnd_d = data.Prior.lbnd_d; ubnd_d = data.Prior.ubnd_d;

% 2) Uncertainty parameters
theta_true = [0.05,0.1,10,70]';

% 3) Design parameters
d_true = [3,10]';

% 4) Intervals
b1 = linspace(lbnd_theta(1),ubnd_theta(1),6)';
b2 = linspace(lbnd_theta(2),ubnd_theta(2),6)';
Qs = linspace(lbnd_theta(3),ubnd_theta(3),6)';
Ntp = linspace(lbnd_theta(4),ubnd_theta(4),6)';

tao_inj = linspace(lbnd_d(1),ubnd_d(1),6)';
c_inj = linspace(lbnd_d(2),ubnd_d(2),6)';

% 5) Perturbations
dire_2 = 'results/perturbations/';
dire = pwd;

Per_b1 = {};
Per_b2 = {};
Per_Qs = {};
Per_Ntp = {};
Per_tao_inj = {};
Per_c_inj = {};

for k = 1:6
	
	% a) Perturbations respect to b1
	theta = theta_true;
	d = d_true;
	theta(1) = b1(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_b1{k,1} = c;
	Per_b1{k,2} = cI;

	% b) Perturbations respect to b2
	theta = theta_true;
	d = d_true;
	theta(2) = b2(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_b2{k,1} = c;
	Per_b2{k,2} = cI;

	% c) Perturbations respect to Qs
	theta = theta_true;
	d = d_true;
	theta(3) = Qs(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_Qs{k,1} = c;
	Per_Qs{k,2} = cI;

	% d) Perturbations respect to Ntp
	theta = theta_true;
	d = d_true;
	theta(4) = Ntp(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_Ntp{k,1} = c;
	Per_Ntp{k,2} = cI;

	% e) Perturbations respect to tao_inj
	theta = theta_true;
	d = d_true;
	d(1) = tao_inj(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_tao_inj{k,1} = c;
	Per_tao_inj{k,2} = cI;

	% f) Perturbations respect to c_inj
	theta = theta_true;
	d = d_true;
	d(2) = c_inj(k); 

	% Save temporal parameters
	save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
	save('results/forward_mapping_evaluation/d.dat','d','-ascii')

	% Run executable
	filename = join([dire,'/FM.out']);
	system(filename);

	% Reading results
	cI = load('results/forward_mapping_evaluation/cI.dat');
	c = load('results/forward_mapping_evaluation/c.dat');
	cI = reshape(cI,[Nt_d,Nc]);
	
	% Save the data
	Per_c_inj{k,1} = c;
	Per_c_inj{k,2} = cI;

end

% 6) Plot
dire = 'results/perturbations/';
plots_random(tao,tao_dat,Per_b1,Per_b2,Per_Qs,Per_Ntp,Per_tao_inj,Per_c_inj,...
Nc,tao_inj,c_inj,b1,b2,Qs,Ntp,6,dire)



