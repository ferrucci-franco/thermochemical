%% nh3_v4.mat TEST SCRIPT (T,rho) INDEPENDENT VARIABLES
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Oct 2018

%% Cleanup
clearvars -except nh3_v4 c
clc

%% f(T,rho), independent variables set
T_K = 300.5;
rho = 150;

%% Load parameters/variables
load nh3_v4.mat
c = conversion_factors();
fluid = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%%
P = CoolProp.PropsSI('P','T',T_K,'Dmolar',rho,fluid)*c.Pa_to_bar;
beta = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',T_K,'Dmolar',rho,fluid);
kappa = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',T_K,'Dmolar',rho,fluid);
h = CoolProp.PropsSI('Hmolar','T',T_K,'Dmolar',rho,fluid);
u = CoolProp.PropsSI('Umolar','T',T_K,'Dmolar',rho,fluid);
s = CoolProp.PropsSI('Smolar','T',T_K,'Dmolar',rho,fluid);
Cp = CoolProp.PropsSI('Cpmolar','T',T_K,'Dmolar',rho,fluid);
Cv = CoolProp.PropsSI('Cvmolar','T',T_K,'Dmolar',rho,fluid);
phase_idx = CoolProp.PropsSI('PHASE','T',T_K,'Dmolar',rho,fluid);
phase = CoolProp.PhaseSI('T',T_K,'Dmolar',rho,fluid);
%
[P_table,~,~,idx_x,idx_y] = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.P,T_K,rho);
beta_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.beta,T_K,rho);
kappa_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.kappa,T_K,rho);
h_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.h_molar,T_K,rho);
u_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.u_molar,T_K,rho);
s_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.s_molar,T_K,rho);
Cp_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.Cp_molar,T_K,rho);
Cv_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.Cv_molar,T_K,rho);
phase_table = lookUp(nh3_v4.no_sat.T_rho_indep.var_indep.T,...
                   nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar,...
                   nh3_v4.no_sat.T_rho_indep.var_dep.phase,T_K,rho);
               
%%