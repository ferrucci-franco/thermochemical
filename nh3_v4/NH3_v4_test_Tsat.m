%% nh3_v4.mat TEST SCRIPT (Tsat) INDEPENDENT VARIABLE
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Oct 2018

%% Cleanup
clearvars -except nh3_v4 c
clc

%% f(T,P), independent variables set
Tsat = 300;

%% Load parameters/variables
load nh3_v4.mat
c = conversion_factors();
fluid = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS('Ammonia','NBP');

%% Liquid
rho_liq = CoolProp.PropsSI('Dmolar','T',Tsat,'Q',0,fluid);
beta_liq = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',Tsat,'Q',0,fluid);
kappa_liq = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',Tsat,'Q',0,fluid);
h_liq = CoolProp.PropsSI('Hmolar','T',Tsat,'Q',0,fluid);
u_liq = CoolProp.PropsSI('Umolar','T',Tsat,'Q',0,fluid);
s_liq = CoolProp.PropsSI('Smolar','T',Tsat,'Q',0,fluid);
Cp_liq = CoolProp.PropsSI('Cpmolar','T',Tsat,'Q',0,fluid);
Cv_liq = CoolProp.PropsSI('Cvmolar','T',Tsat,'Q',0,fluid);
phase_liq = CoolProp.PhaseSI('T',Tsat,'Q',0,fluid);
%
[rho_liq_table,~,idx_x] = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.rho_molar,Tsat);
beta_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.beta,Tsat);
kappa_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.kappa,Tsat);
h_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.h_molar,Tsat);
u_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.u_molar,Tsat);
s_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.s_molar,Tsat);
Cp_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.Cp_molar,Tsat);
Cv_liq_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.liq.Cv_molar,Tsat);
               
%% Gas
rho_gas = CoolProp.PropsSI('Dmolar','T',Tsat,'Q',1,fluid);
beta_gas = CoolProp.PropsSI('ISOBARIC_EXPANSION_COEFFICIENT','T',Tsat,'Q',1,fluid);
kappa_gas = CoolProp.PropsSI('ISOTHERMAL_COMPRESSIBILITY','T',Tsat,'Q',1,fluid);
h_gas = CoolProp.PropsSI('Hmolar','T',Tsat,'Q',1,fluid);
u_gas = CoolProp.PropsSI('Umolar','T',Tsat,'Q',1,fluid);
s_gas = CoolProp.PropsSI('Smolar','T',Tsat,'Q',1,fluid);
Cp_gas = CoolProp.PropsSI('Cpmolar','T',Tsat,'Q',1,fluid);
Cv_gas = CoolProp.PropsSI('Cvmolar','T',Tsat,'Q',1,fluid);
phase_gas = CoolProp.PhaseSI('T',Tsat,'Q',1,fluid);
%
[rho_gas_table,~,idx_x] = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.rho_molar,Tsat);
beta_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.beta,Tsat);
kappa_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.kappa,Tsat);
h_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.h_molar,Tsat);
u_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.u_molar,Tsat);
s_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.s_molar,Tsat);
Cp_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.Cp_molar,Tsat);
Cv_gas_table = lookUp_1D(nh3_v4.sat.T,nh3_v4.sat.vap.Cv_molar,Tsat);
