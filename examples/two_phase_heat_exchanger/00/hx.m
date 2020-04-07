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
Thx_init = c.C_to_K(25);
Nhx_init = 100;
Vhx = 0.01;

%% Inputs

% Q:
q = 1e2;
tStart_q = 5 * c.min_to_sec;
tEnd_q = tStart_q + 10 * c.min_to_sec;

% Fluid in:
T_dnDt_in_C = 50;
dnDt_in = 1e-2;
tStart_dnDt_in = tEnd_q + 10 * c.min_to_sec;
tEnd_dnDt_in = tStart_dnDt_in + 10 * c.min_to_sec;

% Vapor out:
dnDt_out_vap = 1e-2;
tStart_dnDt_out_vap = tEnd_dnDt_in + 10 * c.min_to_sec;
tEnd_dnDt_out_vap = tStart_dnDt_out_vap + 10 * c.min_to_sec;

% Liquid out:
dnDt_out_liq = 1e-2;
tStart_dnDt_out_liq = tEnd_dnDt_out_vap + 10 * c.min_to_sec;
tEnd_dnDt_out_liq = tStart_dnDt_out_liq + 10 * c.min_to_sec;

% End of simulation:
tEndSimul = tEnd_dnDt_out_liq + 10 * c.min_to_sec;
