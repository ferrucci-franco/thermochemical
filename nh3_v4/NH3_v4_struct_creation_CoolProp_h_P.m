%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Non-saturated, (h,P) independent variables
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
dh = 40; % 400;
dP_bar = 0.1; % 2;

%% Independent variables limits
h_min = -2.9e3;
h_max = 43e3;
%
Pmin = nh3_v4.constants.Pmin;
Pmax = nh3_v4.constants.Pmax;

%% Independent variables initialization:
h_molar = h_min:dh:h_max;
%
P_bar = Pmin:dP_bar:Pmax;
P_Pa = P_bar * nh3_v4.constants.bar_to_Pa;

%% Dependent variables initialization:
N1 = length(h_molar);
N2 = length(P_Pa);
%
h_P_indep.T = zeros(N1,N2);
h_P_indep.rho_molar = zeros(N1,N2);
h_P_indep.beta = zeros(N1,N2);
h_P_indep.kappa = zeros(N1,N2);
h_P_indep.s_molar = zeros(N1,N2);
h_P_indep.u_molar = zeros(N1,N2);
h_P_indep.Cp_molar = zeros(N1,N2);
h_P_indep.Cv_molar = zeros(N1,N2);
h_P_indep.phase = zeros(N1,N2);

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%% Loop
for i = 1:N1
    for j = 1:N2
        h_P_indep.T(i,j) = CoolProp.PropsSI('T','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.rho_molar(i,j) = CoolProp.PropsSI('Dmolar','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.beta(i,j) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.kappa(i,j) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.s_molar(i,j) = CoolProp.PropsSI('Smolar','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.u_molar(i,j) = CoolProp.PropsSI('Umolar','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.Cp_molar(i,j) = CoolProp.PropsSI('Cpmolar','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.Cv_molar(i,j) = CoolProp.PropsSI('Cvmolar','Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia');
        h_P_indep.phase(i,j) = CoolProp.get_phase_index(['phase_' CoolProp.PhaseSI('Hmolar',h_molar(i),'P',P_Pa(j),'Ammonia')]);
    end
end

%% Cp, beta, kappa are not defined inside the two-phase dome...converting to NaN
idx = h_P_indep.phase == 6;
h_P_indep.Cp_molar(idx) = NaN;
h_P_indep.beta(idx) = NaN;
h_P_indep.kappa(idx) = NaN;

%% Create final struture
nh3_v4.no_sat.h_P_indep.var_indep.h_molar = h_molar;
nh3_v4.no_sat.h_P_indep.var_indep.P = P_bar;
nh3_v4.no_sat.h_P_indep.var_dep = h_P_indep;

%% Save MAT file
save nh3_v4.mat nh3_v4

%% Done!
disp('Done (h,P)')