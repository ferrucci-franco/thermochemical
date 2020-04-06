%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Saturation properties
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

%% Load struct
load nh3_v4.mat

%% Independent variables grid space
dT_K = 0.5;

%% Independent variables initialization:
sat.T = nh3_v4.constants.Tmin:dT_K:nh3_v4.constants.Tcritic;

%% Dependent variables initialization:
N = length(sat.T);
%
sat.Psat = zeros(N,1);
%
sat.liq.rho_molar = zeros(N,1);
sat.liq.beta = zeros(N,1);
sat.liq.kappa = zeros(N,1);
sat.liq.h_molar = zeros(N,1);
sat.liq.u_molar = zeros(N,1);
sat.liq.s_molar = zeros(N,1);
sat.liq.Cp_molar = zeros(N,1);
sat.liq.Cv_molar = zeros(N,1);
%
sat.vap.rho_molar = zeros(N,1);
sat.vap.beta = zeros(N,1);
sat.vap.kappa = zeros(N,1);
sat.vap.h_molar = zeros(N,1);
sat.vap.u_molar = zeros(N,1);
sat.vap.s_molar = zeros(N,1);
sat.vap.Cp_molar = zeros(N,1);
sat.vap.Cv_molar = zeros(N,1);

%% Loop
for i = 1:N
    sat.Psat(i) = CoolProp.PropsSI('P','T',sat.T(i),'Q',0,'Ammonia');
    %
    sat.liq.rho_molar(i) = CoolProp.PropsSI('Dmolar','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.beta(i) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.kappa(i) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.h_molar(i) = CoolProp.PropsSI('Hmolar','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.u_molar(i) = CoolProp.PropsSI('Umolar','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.s_molar(i) = CoolProp.PropsSI('Smolar','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.Cp_molar(i) = CoolProp.PropsSI('Cpmolar','T',sat.T(i),'Q',0,'Ammonia');
    sat.liq.Cv_molar(i) = CoolProp.PropsSI('Cvmolar','T',sat.T(i),'Q',0,'Ammonia');
    %
    sat.vap.rho_molar(i) = CoolProp.PropsSI('Dmolar','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.beta(i) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.kappa(i) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',sat.T(i),'Q',1,'Ammonia');    
    sat.vap.h_molar(i) = CoolProp.PropsSI('Hmolar','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.u_molar(i) = CoolProp.PropsSI('Umolar','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.s_molar(i) = CoolProp.PropsSI('Smolar','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.Cp_molar(i) = CoolProp.PropsSI('Cpmolar','T',sat.T(i),'Q',1,'Ammonia');
    sat.vap.Cv_molar(i) = CoolProp.PropsSI('Cvmolar','T',sat.T(i),'Q',1,'Ammonia');    
end

%% Elimination of the glitch of Cp(end):
% sat.liq.Cp_molar(end) = sat.liq.Cp_molar(end-1);
% sat.vap.Cp_molar(end) = sat.vap.Cp_molar(end-1);

%% Convert Pa to bar
sat.Psat = sat.Psat * nh3_v4.constants.Pa_to_bar;

%% Create final struture
nh3_v4.sat = sat;

%% Save MAT file
save nh3_v4.mat nh3_v4
