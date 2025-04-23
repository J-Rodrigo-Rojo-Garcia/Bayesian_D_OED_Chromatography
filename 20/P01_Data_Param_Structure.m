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
% Data Parameter structure

% In this script is saved the structure of all parameters used for the 
% simulations. They will be saved in a file. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed parameters of the model
Nc = 2;
F = 1.5;
L = 50;

% True uncertainty parameters
b = [0.05,0.1];
Qs = 10;
Ntp = 70;

% Dimensions
N_th = 4;		
N_OED = 2;

% Design parameters for modelling
tao_inj = 3;
c_Feed = 10;

% Parameters for numerical method
eta = 10^(-10);
Mu = 1.0;
Lambda = 0.5;

% Structure
Model.Nc = Nc; Model.F = F; Model.tao_inj = tao_inj; Model.b = b; Model.Qs = Qs;
Model.Ntp = Ntp; Model.N_th = N_th; Model.N_OED = N_OED; Model.c_Feed = c_Feed;
Model.eta = eta; Model.Mu = Mu; Model.Lambda = Lambda; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Prior intervals

% In this case:
% theta := (b_1,b_2,Qs,Dapp)
% d := (c_Feed,u)

% Uncertainty parameters
lbnd_theta = [0.02;0.03;8;50];
ubnd_theta = [0.08;0.17;11;180];

% Design parameters
lbnd_d = [0.05;1]; 
ubnd_d = [3;15];

% Structure
Prior.lbnd_theta = lbnd_theta; Prior.ubnd_theta = ubnd_theta; 
Prior.lbnd_d = lbnd_d; Prior.ubnd_d = ubnd_d; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Gaussian Noise
Sigma = 0.05;
Sigma2 = Sigma*Sigma;

% Structure
Noise.Sigma = Sigma; Noise.Sigma2 = Sigma2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discretization

% Space discretization
Ny = 201;
y = linspace(0,1,Ny)';
dy = y(2) - y(1);

% Time discretization
dt1 = Mu*dy/1;
dt2 = (Lambda*dy*dy)/(0.5/lbnd_theta(end));
d_tao = 0.5*min(dt1,dt2);
Tao_T = 10;
N_tao = round(Tao_T/d_tao);
tao = linspace(0,Tao_T,N_tao)';

% Artificial data
Nt_d = 20;
Nd = Nt_d*Nc;
tao_dat = linspace(0.5,Tao_T-0.5,Nt_d)';

% Nodes Forward Mapping
In = nearest_nodes(tao,tao_dat);
Lag = coef_lagrange_interp(tao,tao_dat,In,Nt_d);

% Structure
Numeric.Ny = Ny; Numeric.y = y; Numeric.dy = dy; Numeric.d_tao = d_tao; 
Numeric.Tao_T = Tao_T; Numeric.N_tao = N_tao; Numeric.tao = tao;
Numeric.Nt_d = Nt_d; Numeric.Nd = Nd; Numeric.tao_dat = tao_dat; 
Numeric.In = In; Numeric.Lag = Lag;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Inversion

% Parameters
Theta = [b,Qs,Ntp]';
D = [tao_inj,c_Feed]';

% Structure
Inversion.Theta = Theta; Inversion.D = D; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Saving data
save('matlab_data/Structure_Model.mat','Model','Prior','Noise','Numeric','Inversion')

