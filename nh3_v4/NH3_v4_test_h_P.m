%% nh3_v4.mat TEST SCRIPT (h,P) INDEPENDENT VARIABLES
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Oct 2018

%% Cleanup
clearvars -except nh3_v4 c
clc

%% f(h,P), independent variables set
h = 25000;
P_bar = 5;

%% Load parameters/variables
load nh3_v4.mat
c = conversion_factors();
fluid = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%%
rho = CoolProp.PropsSI('Dmolar','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
beta = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
kappa = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
T = CoolProp.PropsSI('T','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
u = CoolProp.PropsSI('Umolar','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
s = CoolProp.PropsSI('Smolar','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
Cp = CoolProp.PropsSI('Cpmolar','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
Cv = CoolProp.PropsSI('Cvmolar','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
phase_idx = CoolProp.PropsSI('PHASE','Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
phase = CoolProp.PhaseSI('Hmolar',h,'P',P_bar*c.bar_to_Pa,fluid);
%
[rho_table,~,~,idx_x,idx_y] = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.rho_molar,h,P_bar);
beta_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.beta,h,P_bar);
kappa_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.kappa,h,P_bar);
T_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.T,h,P_bar);
u_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.u_molar,h,P_bar);
s_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.s_molar,h,P_bar);
Cp_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.Cp_molar,h,P_bar);
Cv_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.Cv_molar,h,P_bar);
phase_table = lookUp(nh3_v4.no_sat.h_P_indep.var_indep.h_molar,...
                   nh3_v4.no_sat.h_P_indep.var_indep.P,...
                   nh3_v4.no_sat.h_P_indep.var_dep.phase,h,P_bar);
               
%%