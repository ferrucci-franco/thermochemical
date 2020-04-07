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

%% Compressor speed

% Initial motor speed (rmp):
rpm_init = 500;

% Reference speed when turned on (rpm):
rpm_nominal = 1450;

% Time of motor turn-on (sec):
rpm_start_time = 1 * c.min_to_sec;

% Sweep time:
tSweep = 200;

% Simulation end time:
tEndSim = rpm_start_time + tSweep;

% Ramp slope:
slope = (rpm_nominal-rpm_init)/tSweep;


%% Motor parameters 
% Motor model: DC083B-2 (ID33005) Brush DC Motor
% Datasheet: www.pittman-motors.com/Brush-DC-Motors/ID33005-Brush-DC-Motor.aspx

% Armature inductance (Hy):
La_motor = 2.31e-3; % 1e-1;

% Armature resistance (Ohm):
Ra_motor = 1.5;

% Mechanical inertia (kg.m2):
J_motor = 0.1; % 10;

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

% Maximun electrical power available (W):
Imax_motor = 33.2; % [A] current that gives the maximun torque (see datasheet)
Power_max = Inf; % Vmax_motor * Imax_motor;

%% 

