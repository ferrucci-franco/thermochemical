%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Non-saturated, (T,rho) independent variables
%
% To install CoopProp for Matlab, follow these steps:
% http://www.coolprop.org/coolprop/wrappers/MATLAB/index.html#pre-compiled-binaries

% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Sept 2018

%% Cleanup
clear
close all
% clc

%% Load struct
load nh3_v4.mat

%% Independent variables grid space
dT_K = 0.5; % 10;
dRho_molar = 10; % 1e3;

%% Independent variables limits
Tmin = nh3_v4.constants.Tmin;
Tmax = nh3_v4.constants.Tmax;
%
rho_molar_min = 1;
rho_molar_max = 4e4;

%% Independent variables initialization:
T_K = Tmin:dT_K:Tmax;
rho_molar = 0:dRho_molar:rho_molar_max;
rho_molar(1) = rho_molar_min;

%% Dependent variables initialization:
N1 = length(T_K);
N2 = length(rho_molar);
%
T_rho_indep.P = zeros(N1,N2);
T_rho_indep.beta = zeros(N1,N2);
T_rho_indep.kappa = zeros(N1,N2);
T_rho_indep.h_molar = zeros(N1,N2);
T_rho_indep.u_molar = zeros(N1,N2);
T_rho_indep.s_molar = zeros(N1,N2);
T_rho_indep.Cp_molar = zeros(N1,N2);
T_rho_indep.Cv_molar = zeros(N1,N2);
T_rho_indep.phase = zeros(N1,N2);

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%% Loop
for i = 1:N1
    for j = 1:N2
        T_rho_indep.P(i,j) = CoolProp.PropsSI('P','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia') * nh3_v4.constants.Pa_to_bar;
        T_rho_indep.beta(i,j) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.kappa(i,j) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.h_molar(i,j) = CoolProp.PropsSI('Hmolar','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.u_molar(i,j) = CoolProp.PropsSI('Umolar','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.s_molar(i,j) = CoolProp.PropsSI('Smolar','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.Cp_molar(i,j) = CoolProp.PropsSI('Cpmolar','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.Cv_molar(i,j) = CoolProp.PropsSI('Cvmolar','T',T_K(i),'Dmolar',rho_molar(j),'Ammonia');
        T_rho_indep.phase(i,j) = CoolProp.get_phase_index(['phase_' CoolProp.PhaseSI('T',T_K(i),'Dmolar',rho_molar(j),'Ammonia')]);
    end
end

%% Cp, beta, kappa are not defined inside the two-phase dome...converting to NaN
idx = T_rho_indep.phase == 6;
T_rho_indep.Cp_molar(idx) = NaN;
T_rho_indep.beta(idx) = NaN;
T_rho_indep.kappa(idx) = NaN;

%% Create final struture
nh3_v4.no_sat.T_rho_indep.var_indep.T = T_K;
nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar = rho_molar;
nh3_v4.no_sat.T_rho_indep.var_dep = T_rho_indep;

%% Save MAT file
save nh3_v4.mat nh3_v4

%% Done!
disp('Done (T,rho)')