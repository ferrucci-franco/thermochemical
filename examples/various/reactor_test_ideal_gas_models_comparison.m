%% PROTOTYPE - COMPUTATION OF MOLES OF EACH ELEMENT
% 

%% Cleanup
clear 
close all
clc

%% Parameters
c = conversion_factors();
load nh3_v4.mat;

%% Input parameters
param.pairName = 'Barium chloride/Ammonia (BaCl2/NH3)';
param.binderName = 'ENG';
param.gasName = 'Ammonia gas (NH3)';
param.Tr_init = c.C_to_K(25);
param.X_init = 0.9;
param.Lr = 20 * 46.5 * c.mm_to_m; % 20 wafers
param.Lr_total = 0.98;
param.D = 108.3 * c.mm_to_m;
param.Ddiff = 16 * c.mm_to_m;
param.tao_salt = 0.74;
param.rho_composite = 384.6;

%% Function call
y = blk_reactor_BaCl2_NH3_cylindrical_no_walls_fun1(param);

%% Create list of variables to match simulink block variables' names
N_salt = y.N_salt;
N_binder = y.N_binder;
K_cin = 1e-3;
V_void = y.Vvoid_m3;
N_gas_free_volume_init = y.N_gas_free_volume_init;
%
fluid = nh3_v4;
Tr_init = param.Tr_init;
X_init = param.X_init;



