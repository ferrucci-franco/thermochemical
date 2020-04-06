%% TABLE GENERATOR OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
% Non-saturated, (T,P) independent variables
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
dT_K = 0.5; % 5
dP_bar = 0.1; % 2

%% Independent variables limits
Tmin = nh3_v4.constants.Tmin;
Tmax = nh3_v4.constants.Tmax;
%
Pmin = nh3_v4.constants.Pmin;
Pmax = nh3_v4.constants.Pmax;

%% Independent variables initialization:
T_K = Tmin:dT_K:Tmax;
P_bar = Pmin:dP_bar:Pmax;
P_Pa = P_bar * nh3_v4.constants.bar_to_Pa;

%% Dependent variables initialization:
N1 = length(T_K);
N2 = length(P_Pa);
%
T_P_indep.rho_molar = zeros(N1,N2);
T_P_indep.beta = zeros(N1,N2);
T_P_indep.kappa = zeros(N1,N2);
T_P_indep.h_molar = zeros(N1,N2);
T_P_indep.u_molar = zeros(N1,N2);
T_P_indep.s_molar = zeros(N1,N2);
T_P_indep.Cp_molar = zeros(N1,N2);
T_P_indep.Cv_molar = zeros(N1,N2);
T_P_indep.phase = zeros(N1,N2);

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%% Loop
for i = 1:N1
    for j = 1:N2
        try
            T_P_indep.rho_molar(i,j) = CoolProp.PropsSI('Dmolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.beta(i,j) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.kappa(i,j) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.h_molar(i,j) = CoolProp.PropsSI('Hmolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.u_molar(i,j) = CoolProp.PropsSI('Umolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.s_molar(i,j) = CoolProp.PropsSI('Smolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.Cp_molar(i,j) = CoolProp.PropsSI('Cpmolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.Cv_molar(i,j) = CoolProp.PropsSI('Cvmolar','T',T_K(i),'P',P_Pa(j),'Ammonia');
            T_P_indep.phase(i,j) = CoolProp.get_phase_index(['phase_' CoolProp.PhaseSI('T',T_K(i),'P',P_Pa(j),'Ammonia')]);
        catch
            dT = 1e-3*randn;
            T_P_indep.rho_molar(i,j) = CoolProp.PropsSI('Dmolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.beta(i,j) = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.kappa(i,j) = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.h_molar(i,j) = CoolProp.PropsSI('Hmolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.u_molar(i,j) = CoolProp.PropsSI('Umolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.s_molar(i,j) = CoolProp.PropsSI('Smolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.Cp_molar(i,j) = CoolProp.PropsSI('Cpmolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.Cv_molar(i,j) = CoolProp.PropsSI('Cvmolar','T',T_K(i)+dT,'P',P_Pa(j),'Ammonia');
            T_P_indep.phase(i,j) = CoolProp.get_phase_index(['phase_' CoolProp.PhaseSI('T',T_K(i)+dT,'P',P_Pa(j),'Ammonia')]);
            disp(['T_P_indep catched! i = ', num2str(i), ', j = ', num2str(j)])
        end
    end
end

%% Create final struture
nh3_v4.no_sat.T_P_indep.var_indep.T = T_K;
nh3_v4.no_sat.T_P_indep.var_indep.P = P_bar;
nh3_v4.no_sat.T_P_indep.var_dep = T_P_indep;

%% Save MAT file
save nh3_v4.mat nh3_v4

%% Done!
disp('Done (T,P)')