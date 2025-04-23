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
% This subroutine runs the Forward Mapping made in Fortran and plot it
% (Only for see the simulation)

% 1) Reading the parameters
data = load('matlab_data/Structure_Model.mat');
Numeric = data.Numeric; Model = data.Model;
tao = Numeric.tao; tao_dat = Numeric.tao_dat; Nt_d = Numeric.Nt_d; Nc = Model.Nc;

% 2) Uncertainty parameters
theta = [0.05,0.1,10,70]';

% 3) Design parameters
d = [3,10]';

% 4) Save data
save('results/forward_mapping_evaluation/theta.dat','theta','-ascii')
save('results/forward_mapping_evaluation/d.dat','d','-ascii')

% 5) Run executable
dire = pwd;
filename = join([dire,'/FM.out']);
system(filename);

% 6) Reading results
cI = load('results/forward_mapping_evaluation/cI.dat');
c = load('results/forward_mapping_evaluation/c.dat');
cI = reshape(cI,[Nt_d,Nc]);

% 7) Plot
dire = 'results/forward_mapping_evaluation/';
filename = 'FM';
Title = 'Forward Mapping';
plots_FM(tao_dat,tao,c,cI,Nc,dire,filename,Title)




