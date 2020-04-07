%% DESORPTION
% 

%% Cleanup
clear 
close all
clc

%% Cleanup
clearvars -except fluid
close all
clc

%% Parameters
c = conversion_factors();
if ~exist('fluid','var')
    load nh3_v4.mat;
    fluid = nh3_v4;
    clearvars nh3_v4
end

%% Reactor
% Heat transfer with ambient:
Tamb_C = 25;
Tdesorp_source_C = 40;
Treactor_wall_init = c.C_to_K(Tdesorp_source_C);
h_reactor_air = 200;
%
param.pairName = 'Barium chloride/Ammonia (BaCl2/NH3)';
param.binderName = 'ENG';
param.gasName = 'Ammonia gas (NH3)';
param.Tr_init = c.C_to_K(Tdesorp_source_C);
param.X_init = 0.9;
param.Lr = 20 * 46.5 * c.mm_to_m; % 20 wafers
param.Lr_total = 0.98;
param.D = 108.3 * c.mm_to_m;
param.Ddiff = 16 * c.mm_to_m;
param.tao_salt = 0.74;
param.rho_composite = 384.6;
K_cin = 1e-3;
thickness_mm = 2.9;
OD_mm = param.D * c.m_to_mm + 2 * thickness_mm;

% % Additional parameters (not needed):
% y = blk_reactor_BaCl2_NH3_cylindrical_no_walls_fun1(param);
% N_salt = y.N_salt;
% N_binder = y.N_binder;
% V_void = y.Vvoid_m3;
% N_gas_free_volume_init = y.N_gas_free_volume_init;
% dataBaCl2 = get_material_properties('Barium chloride/Ammonia (BaCl2/NH3)');
% dataENG = get_material_properties('ENG');
% cp_gas = dataBaCl2.cp_gas;
% cp_S1 =  dataBaCl2.cp_salt + dataBaCl2.nu * cp_gas;
% cp_S0 = dataBaCl2.cp_salt;
% cp_binder = dataENG.cp_molar;
% nu = dataBaCl2.nu;
% dH = dataBaCl2.dh_r;

%% Compressor parameters
% Isentropic efficiency [0..1]:
eta_IS = 0.72;

% Mechanic efficiency, compressor without motor ([0..1]):
eta_mech = 0.9;

% Cylinder clearance ([0..1]):
CL = 0.18;

% Nominal swept volume (m3/h):
dVswept_m3_h = 6;
dVswept_rmp  = 1450;

% Armature inductance (Hy):
La_motor = 2.31e-3; % 1e-1;

% Armature resistance (Ohm):
Ra_motor = 2;

% Mechanical inertia (kg.m2):
J_motor = 0.1;

% Viscous friction coefficient (N.m.sec):
b_motor = 1e-3;

% Electromechanical constant (N.m/A or V/rad/sec):
Km_motor = 10*0.128;

% PID controller, proportional gain:
PID_P_motor = 4;

% PID controller, integral gain:
PID_I_motor = 10;

% PID controller, derivative gain:
PID_D_motor = 0;

% Power source, maximum output voltage (V):
Vmax_motor = 500;

% Initial motor speed (rmp):
rpm_init = 0;
% Time of motor turn-on (sec):
rpm_ref_01_time = 15 * c.min_to_sec;
% Initial reference speed (rpm):
rpm_ref_init = 0;
% Reference speed (rmp):
rpm_ref_01 = 100;

% Reference 2 time (sec):
rpm_ref_02_time = rpm_ref_01_time + 15 * c.min_to_sec;
% Reference 2 speed (rmp):
rpm_ref_02 = rpm_ref_01/2;

%% Condenser
rho_nh3_Tamb = CoolProp.PropsSI('Dmolar','T',c.C_to_K(Tamb_C),'Q',0,'Ammonia');
Vhx = (0.5 + 2.5)* c.L_to_m3;
Shx_m2 = 0.351;
thickness_hx_mm = 0.8;
Nhx_init = Vhx/20 * rho_nh3_Tamb;

% Heat transfer coeff:
h_wall_water = 200;
h_liq_wall = 1e2;
h_vap_wall = 1e4;

% T water:
Twater_in_C = 20;
L_min_water = 5;
Thx_init = c.C_to_K(Tamb_C);

%% End of simulation:
tEndSimul = rpm_ref_01_time + 60*c.min_to_sec;


