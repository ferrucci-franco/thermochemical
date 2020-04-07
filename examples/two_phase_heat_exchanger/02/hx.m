%% 
% 

%% Cleanup
clear 
close all
clc

%% Parameters
c = conversion_factors();
load nh3_v4.mat;
fluid = nh3_v4;

%% Input parameters
Tamb_C = 25;
rho_nh3_Tamb = CoolProp.PropsSI('Dmolar','T',c.C_to_K(Tamb_C),'Q',0,'Ammonia');
Thx_init = c.C_to_K(Tamb_C);
Vhx = 0.5 * c.L_to_m3;
Shx_m2 = 0.351;
thickness_hx_mm = 0.8;
Nhx_init = Vhx/1.2 * rho_nh3_Tamb;

%% Inputs
% Heat transfer coeff:
h_outer = 200;
h_inner_liq = 1e4;
h_inner_vap = 1e2;

% T out:
Tout1_C = (0+10)/2;

% Fluid in:
T_dnDt_in_C = 120;
dnDt_in = mass_flow_converter(0, 'kg/min', 'mol/sec', 'Ammonia');
tStart_dnDt_in = 10 * c.min_to_sec;
tEnd_dnDt_in = tStart_dnDt_in + 10 * c.min_to_sec;

% Vapor out:
dnDt_out_vap = mass_flow_converter(0.020, 'kg/min', 'mol/sec', 'Ammonia');
tStart_dnDt_out_vap = 5 * c.min_to_sec;
tEnd_dnDt_out_vap = tStart_dnDt_out_vap + 10 * c.min_to_sec;

% Liquid out:
dnDt_out_liq = mass_flow_converter(0, 'kg/min', 'mol/sec', 'Ammonia');
tStart_dnDt_out_liq = 5 * c.min_to_sec;
tEnd_dnDt_out_liq = tStart_dnDt_out_liq + 10 * c.min_to_sec;

% End of simulation:
tEndSimul = tEnd_dnDt_out_vap + 5 * c.min_to_sec;
