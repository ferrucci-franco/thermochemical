%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Initialization script
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

%% Units
units.T = 'K';
units.P = 'bar';
units.Psat = 'bar';
units.Pmin = 'bar';
units.Pmax = 'bar';
units.Tmin = 'K';
units.Tmax = 'K';
units.Tcritic = 'K';
units.Pcritic = 'bar';
units.Molar_mass = 'kg/mol';
units.rho_molar = 'mol/m3';
units.beta = '1/K';
units.kappa = '1/Pa';
units.h_molar = 'J/mol';
units.u_molar = 'J/mol';
units.s_molar = 'J/K/mol';
units.Cp_molar = 'J/K/mol';
units.Cv_molar = 'J/K/mol';
units.R = 'J/K/mol';

%% Definition of some constansts
constants.Pa_to_bar = 1e-5;
constants.bar_to_Pa = 1e+5;
constants.Tkelvin = 273.15;
constants.R = 8.314472; % [J/mol/K], ideal gas constant
%
constants.Tmin = 230; % -43.15°C
constants.Tmax = 700; % 426.85°C 
%
constants.Pmin = 0.2;
constants.Pmax = 150;
%
constants.Tcritic = CoolProp.Props1SI('T_CRITICAL','Ammonia');
constants.Pcritic = CoolProp.Props1SI('P_CRITICAL','Ammonia')*constants.Pa_to_bar;
constants.Molar_mass = CoolProp.Props1SI('MOLARMASS','Ammonia');
constants.Reference = 'NBP: h=0, s=0 for saturated liquid at 1 atmosphere';
constants.Phase_index = {
    '0: Subcritical liquid',...                     % iphase_liquid
    '1: Supercritical (p > pc, T > Tc)',...         % iphase_supercritical
    '2: Supercritical gas (p < pc, T > Tc)',...     % iphase_supercritical_gas
    '3: Supercritical liquid (p > pc, T < Tc)',...  % iphase_supercritical_liquid
    '4: At the critical point',...                  % iphase_critical_point
    '5: Subcritical gas',...                        % iphase_gas
    '6: Two phase',...                              % iphase_twophase
    '7: Unknown phase',...                          % iphase_unknown
    '8: Not imposed'};                              % iphase_not_imposed

%% Create final struture
nh3_v4.constants = constants;
nh3_v4.units = units;

%% Save MAT file
save nh3_v4.mat nh3_v4

%% Done!
disp('Done with initializatoin!')