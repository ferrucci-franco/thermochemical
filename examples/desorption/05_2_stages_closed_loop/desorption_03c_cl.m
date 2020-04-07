%% DESORPTION
% IMPORTANT NOTE:
% Close and reopen the Simulink file before starting a new simulation. This
% is because on of the masks are not updating properly, and thus some
% blocks (for sure the reactor) retain old parameters.
% 
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

% Close Simulink model, if it was loaded:
if bdIsLoaded('desorption_03c_sim_cl')
    close_system('desorption_03c_sim_cl.slx');
end

%% Sensitivity parameters
h_desorp = 200;
Tdesorp_C = 25;
Ngalettes = 4 * (20);
Kcin = 1e-3;
Tdisch = 180;
Xinit = 0.99;
Xend = Xinit - 0.9;
L_min_water_condenser = 20;
m2_heat_exchanger = 2*(0.351);
m3_heat_exchanger = 2*(0.5* c.L_to_m3);

%% Reactor
% Heat transfer with ambient:
Tamb_C = 25;
Tdesorp_source_C = Tdesorp_C;
Treactor_wall_init = c.C_to_K(Tdesorp_source_C);
h_reactor_air = h_desorp;
%
param.pairName = 'Barium chloride/Ammonia (BaCl2/NH3)';
param.binderName = 'ENG';
param.gasName = 'Ammonia gas (NH3)';
param.Tr_init = c.C_to_K(Tdesorp_source_C);
param.X_init = Xinit;
param.Lr = Ngalettes * 46.5 * c.mm_to_m;
param.Lr_total = param.Lr + 50*c.mm_to_m;
param.D = 108.3 * c.mm_to_m;
param.Ddiff = 16 * c.mm_to_m;
param.tao_salt = 0.74;
param.rho_composite = 384.6;
K_cin = Kcin;
thickness_mm = 2.9;
OD_mm = param.D * c.m_to_mm + 2 * thickness_mm;

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
Km_motor = 3.5;

% PID controller, proportional gain:
PID_P_motor = 3.9;

% PID controller, integral gain:
PID_I_motor = 9;

% PID controller, derivative gain:
PID_D_motor = 0;

% Power source, maximum output voltage (V):
Vmax_motor = 700;

% Initial motor speed (rmp):
rpm_init = 0;

% Compressor maximun allowed speed (rpm):
rpm_max = dVswept_rmp * 2;

% Compressor intercooling, water inlet temperature (°C):
compr_water_Tin_C = Tamb_C;

% Compressor intercooling, water flow rate (L/min):
compr_water_flow_L_min = 10;

% Compressor intercooling, heat exchanger efficiency (0..1):
compr_water_epsilon = 0.8;

%% Condenser
Thx_init = c.C_to_K(Tamb_C);
Vhx = m3_heat_exchanger;
Shx_m2 = m2_heat_exchanger;
thickness_hx_mm = 0.8;
% Nhx_init = 5;
Nhx_init = Vhx/10 * CoolProp.PropsSI('Dmolar','T',Thx_init,'Q',0,'Ammonia');

% Heat transfer coeff:
h_wall_water = 200;
h_liq_wall = 50;
h_vap_wall = 1e4;

% T water:
Twater_in_C = 25;
L_min_water = L_min_water_condenser;

%% Reservoir
% reservoir_L = 0.54*2;
reservoir_L = 0.4 * Ngalettes * 46.5 * c.mm_to_m; % 40%  of the space occupied by the galettes
reservoir_thickness_mm = 2.9;
reservoir_ID_mm = 108.3;
reservoir_OD_mm = reservoir_ID_mm + 2*reservoir_thickness_mm;
reservoir_Tinit = c.C_to_K(Tamb_C);
reservoir_base_area = pi * (reservoir_ID_mm*c.mm_to_m)^2 / 4;
reservoir_V = reservoir_base_area * reservoir_L;
% reservoir_Ninit = 4*2;
reservoir_Ninit = reservoir_V/50 * CoolProp.PropsSI('Dmolar','T',reservoir_Tinit,'Q',0,'Ammonia');
%
h_reservoir_outer = 10;
h_reservoir_inner_liq = 50;
h_reservoir_inner_vap = 10;

%% Controller :
% Time of motor turn-on (and also controller start time) (sec):
motor_start_time_sec = 100 * c.min_to_sec;

PID_P_Tdisch = 5; % 10
PID_I_Tdisch = 0.01;
% PID_P_Tdisch = 50;
% PID_I_Tdisch = 0.1;

% Initial time of averaging functions:
T1 = motor_start_time_sec+0;

% Reference commpressor discharge temperature (°C):
Tdisch_ref_C = Tdisch;
 
%% End of simulation:
% tEndSimul = 300*c.min_to_sec;
tEndSimul = Inf;

%% Open Simulink model
open_system('desorption_03c_sim_cl.slx');

