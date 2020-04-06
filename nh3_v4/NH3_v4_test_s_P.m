%% nh3_v4.mat TEST SCRIPT (s,P) INDEPENDENT VARIABLES
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Oct 2018

%% Cleanup
clearvars -except nh3_v4 c
clc

%% f(s,P), independent variables set
s = 20;
P_bar = 25;

%% Load parameters/variables
load nh3_v4.mat
c = conversion_factors();
fluid = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%%
rho = CoolProp.PropsSI('Dmolar','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
beta = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
kappa = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
T = CoolProp.PropsSI('T','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
u = CoolProp.PropsSI('Umolar','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
h = CoolProp.PropsSI('Hmolar','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
Cp = CoolProp.PropsSI('Cpmolar','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
Cv = CoolProp.PropsSI('Cvmolar','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
phase_idx = CoolProp.PropsSI('PHASE','Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
phase = CoolProp.PhaseSI('Smolar',s,'P',P_bar*c.bar_to_Pa,fluid);
%
[rho_table,~,~,idx_x,idx_y] = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.rho_molar,s,P_bar);
beta_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.beta,s,P_bar);
kappa_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.kappa,s,P_bar);
T_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.T,s,P_bar);
u_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.u_molar,s,P_bar);
h_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.h_molar,s,P_bar);
Cp_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.Cp_molar,s,P_bar);
Cv_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.Cv_molar,s,P_bar);
phase_table = lookUp(nh3_v4.no_sat.s_P_indep.var_indep.s_molar,...
                   nh3_v4.no_sat.s_P_indep.var_indep.P,...
                   nh3_v4.no_sat.s_P_indep.var_dep.phase,s,P_bar);
               
%%