%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Compute ALL strutures
%
% To install CoopProp for Matlab, follow these steps:
% http://www.coolprop.org/coolprop/wrappers/MATLAB/index.html#pre-compiled-binaries

% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Sept 2018

%% Cleanup
clear
close all
clc

%% Call scripts one by one
NH3_v4_struct_creation_CoolProp_init;
NH3_v4_struct_creation_CoolProp_sat;
NH3_v4_struct_creation_CoolProp_T_P;
NH3_v4_struct_creation_CoolProp_T_rho;
NH3_v4_struct_creation_CoolProp_s_P;
NH3_v4_struct_creation_CoolProp_h_P;

%% Plot
NH3_v4_Plots;

