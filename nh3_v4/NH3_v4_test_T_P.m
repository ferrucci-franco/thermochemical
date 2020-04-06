%% nh3_v4.mat TEST SCRIPT (T,P) INDEPENDENT VARIABLES
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Oct 2018

%% Cleanup
clearvars -except nh3_v4 c
clc

%% f(T,P), independent variables set
T_K = 300;
P_bar = 5;

%% Load parameters/variables
load nh3_v4.mat
c = conversion_factors();
fluid = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%%
rho = CoolProp.PropsSI('Dmolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
beta = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
kappa = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
h = CoolProp.PropsSI('Hmolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
u = CoolProp.PropsSI('Umolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
s = CoolProp.PropsSI('Smolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
Cp = CoolProp.PropsSI('Cpmolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
Cv = CoolProp.PropsSI('Cvmolar','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
phase_idx = CoolProp.PropsSI('PHASE','T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
phase = CoolProp.PhaseSI('T',T_K,'P',P_bar*c.bar_to_Pa,fluid);
%
[rho_table,~,~,idx_x,idx_y] = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.rho_molar,T_K,P_bar);
beta_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.beta,T_K,P_bar);
kappa_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.kappa,T_K,P_bar);
h_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.h_molar,T_K,P_bar);
u_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.u_molar,T_K,P_bar);
s_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.s_molar,T_K,P_bar);
Cp_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.Cp_molar,T_K,P_bar);
Cv_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.Cv_molar,T_K,P_bar);
phase_table = lookUp(nh3_v4.no_sat.T_P_indep.var_indep.T,...
                   nh3_v4.no_sat.T_P_indep.var_indep.P,...
                   nh3_v4.no_sat.T_P_indep.var_dep.phase,T_K,P_bar);
               
%%