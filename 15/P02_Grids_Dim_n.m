%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This program generates all the grids for the dimension 7
% and depths 1-n for specific intervals and Smolyak configuration

clear all
close all
clc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Call the directories
addpath 'Piecewise_Sparse'

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data
data_struct = load('matlab_data/Structure_Model.mat');
Model = data_struct.Model;
Prior = data_struct.Prior;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters
lbnd_theta = Prior.lbnd_theta;
ubnd_theta = Prior.ubnd_theta;
lbnd_d = Prior.lbnd_d;
ubnd_d = Prior.ubnd_d;
depth = 1:8;
type_S = 'CC';
Sparse = 'on';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Total

% Bounds
dim = Model.N_th + Model.N_OED; 
lbnd = [lbnd_theta;lbnd_d];
ubnd = [ubnd_theta;ubnd_d];
% Grids
X = Grids_Dim(dim,lbnd,ubnd,depth,type_S,Sparse);
% Save data
filename = 'matlab_data/Grids_dim_tot.mat';
save(filename,'X','dim','lbnd','ubnd','depth','type_S','Sparse','depth')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Case Individual

% Bounds
dim = Model.N_th;
lbnd = lbnd_theta;
ubnd = ubnd_theta;
% Grids
X = Grids_Dim(dim,lbnd,ubnd,depth,type_S,Sparse);
% Save data
filename = 'matlab_data/Grids_dim.mat';
save(filename,'X','dim','lbnd','ubnd','depth','type_S','Sparse','depth')

