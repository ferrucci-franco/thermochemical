function blk_reactor_BaCl2_NH3_cylindrical_no_walls(blk)

%% Simulink block callback.
% Block name: blk_reactor_BaCl2_NH3_cylindrical_no_walls

% This function is used to initialize and update a mask parameter when 
% the user changes some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% March 2018

%% Get mask parameters
param.pairName = get_param(blk,'pairName');
param.binderName = get_param(blk,'binderName');
param.gasName = get_param(blk,'gasName');
param.Tr_init = get_param_eval(blk,'Tr_init');
param.X_init = get_param_eval(blk,'X_init');
param.Lr = get_param_eval(blk,'Lr');
param.Lr_total = get_param_eval(blk,'Lr_total');
param.D = get_param_eval(blk,'Dr');
param.Ddiff = get_param_eval(blk,'Ddiff');
param.tao_salt = get_param_eval(blk,'tao_salt');
param.rho_composite = get_param_eval(blk,'rho_composite');

%% Function call:
y = blk_reactor_BaCl2_NH3_cylindrical_no_walls_fun1(param);

%% Convert back to string
m_composite_str = num2str(y.m_composite_kg);
m_salt_str = num2str(y.m_salt_kg);
m_binder_str = num2str(y.m_binder_kg);
m_gas_str = num2str(y.m_gas_kg);
Vreactor_litre_str = num2str(y.Vreactor_litre);
N_salt_str = num2str(y.N_salt);
N_binder_str = num2str(y.N_binder);
N_gas_free_volume_init_str = num2str(y.N_gas_free_volume_init);
V_void_str = num2str(y.Vvoid_m3);
kWh_cold_str = num2str(y.kWh_cold);

%% Set parameters:
set_param(blk,'m_composite_kg',m_composite_str);
set_param(blk,'m_salt_kg',m_salt_str);
set_param(blk,'m_binder_kg',m_binder_str);
set_param(blk,'m_gas_when_reactor_fully_charged_kg',m_gas_str);
set_param(blk,'Vr_L',Vreactor_litre_str);
set_param(blk,'N_gas_free_volume_init',N_gas_free_volume_init_str);
set_param(blk,'N_salt',N_salt_str);
set_param(blk,'N_binder',N_binder_str);
set_param(blk,'V_void',V_void_str);
set_param(blk,'kWh_cold',kWh_cold_str);

