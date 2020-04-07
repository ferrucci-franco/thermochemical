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
Tamb_C = 25;
param.Tr_init = c.C_to_K(Tamb_C); % CoolProp.PropsSI('T','P',1*c.atm_to_Pa,'Q',0.5,'Ammonia');
param.X_init = 0.5;
param.Lr = 20 * 46.5 * c.mm_to_m; % 20 wafers
param.Lr_total = 0.98;
param.D = 108.3 * c.mm_to_m;
param.Ddiff = 16 * c.mm_to_m;
param.tao_salt = 0.74;
param.rho_composite = 384.6;

% Function call
y = blk_reactor_BaCl2_NH3_cylindrical_no_walls_fun1(param);

% Create list of variables to match simulink block variables' names
% Reactor:
thickness_mm = 2.9;
OD_mm = param.D * c.m_to_mm + 2 * thickness_mm;
% Heater:
heater_thickness_mm = 2;
heater_OD_mm = OD_mm + 2 * heater_thickness_mm;
heater_length_m = param.Lr_total;
R_heater_reactor = 2.5e-3; % Table 1-1: Area-speci?c contact resistance for some interfaces, from Schneider (1985) and Fried (1969).
h_heater_reactor = 1/R_heater_reactor;
h_heater_exterior = 10;
%
N_salt = y.N_salt;
N_binder = y.N_binder;
K_cin = 1e-3;
V_void = y.Vvoid_m3;
N_gas_free_volume_init = y.N_gas_free_volume_init;
fluid = nh3_v4;
Tr_init = param.Tr_init;
X_init = param.X_init;
Ttube_init = Tr_init;
Theater_init = Tr_init;

%% Inputs
% Q:
qOutIn = 100;
tStart_Q = 30 * c.min_to_sec;
tEnd_Q = tStart_Q + 120 * c.min_to_sec;

% dn/dt:
dnDt = 0;
tStart_dnDt = 0;
tEnd_dnDt = 0;

% End of simulation:
tEndSimul = tEnd_Q + 100 * c.min_to_sec;

%%
dataBaCl2 = get_material_properties('Barium chloride/Ammonia (BaCl2/NH3)');
dataENG = get_material_properties('ENG');
%
cp_gas = dataBaCl2.cp_gas;
cp_S1 =  dataBaCl2.cp_salt + dataBaCl2.nu * cp_gas;
cp_S0 = dataBaCl2.cp_salt;
cp_binder = dataENG.cp_molar;
nu = dataBaCl2.nu;
dH = dataBaCl2.dh_r;
