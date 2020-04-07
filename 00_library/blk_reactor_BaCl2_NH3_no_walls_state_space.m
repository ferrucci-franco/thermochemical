function blk_reactor_BaCl2_NH3_no_walls_state_space(blk)

%% Simulink block callback.
% Block name: blk_reactor_BaCl2_NH3_no_walls_state_space

% This function is used to initialize and update a mask parameter when 
% the user changes some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2018

%% Constant values:
c = conversion_factors();
R = c.R; % J/K/mol

%% Set some paremeters
P_dead_zone = 1e-4;
dn_dead_zone = 1e-4;
T_ref = 239.8236; % CoolProp.PropsSI('T','P',1*c.atm_to_Pa,'Q',0.5,'Ammonia');
U_salt_at_X0_T_ref = 0;
U_binder_at_T_ref = 0;
u_gas_at_T_ref = -R * T_ref; % only used if ideal gas model is used.

%% Get a few mask parameters
param.pairName = get_param(blk,'pairName');
param.binderName = get_param(blk,'binderName');
param.N_salt = get_param_eval(blk,'N_salt');
param.N_binder = get_param_eval(blk,'N_binder');

%% Function call
y = blk_reactor_BaCl2_NH3_no_walls_fun1(param);

%% Convert back to string
m_composite_str = num2str(y.m_composite_kg);
m_salt_str = num2str(y.m_salt_kg);
m_binder_str = num2str(y.m_binder_kg);
m_gas_str = num2str(y.m_gas_kg);
%
cP_s0_str = num2str(y.cP_s0);
nu_str = num2str(y.nu);
cP_gas_str = num2str(y.cP_gas);
cP_binder_str = num2str(y.cP_binder);
M_binder_str = num2str(y.M_binder);
dh_r_0_str = num2str(y.dh_r_0);
%
R_str = num2str(R);
%
P_dead_zone_str = num2str(P_dead_zone);
dn_dead_zone_str = num2str(dn_dead_zone);
T_ref_str = num2str(T_ref);
U_salt_at_X0_T_ref_str = num2str(U_salt_at_X0_T_ref);
U_binder_at_T_ref_str = num2str(U_binder_at_T_ref);
u_gas_at_T_ref_str = num2str(u_gas_at_T_ref);

%% Set parameters
set_param(blk,'m_composite_kg',m_composite_str);
set_param(blk,'m_salt_kg',m_salt_str);
set_param(blk,'m_binder_kg',m_binder_str);
set_param(blk,'m_gas_when_reactor_fully_charged',m_gas_str);
set_param(blk,'cP_s0',cP_s0_str);
set_param(blk,'nu',nu_str);
set_param(blk,'cP_gas',cP_gas_str);
set_param(blk,'cP_binder',cP_binder_str);
set_param(blk,'M_binder',M_binder_str);
set_param(blk,'dh_r_0',dh_r_0_str);
set_param(blk,'R',R_str);
set_param(blk,'P_dead_zone',P_dead_zone_str);
set_param(blk,'dn_dead_zone',dn_dead_zone_str);
set_param(blk,'T_ref',T_ref_str);
set_param(blk,'U_salt_at_X0_T_ref',U_salt_at_X0_T_ref_str);
set_param(blk,'U_binder_at_T_ref',U_binder_at_T_ref_str);
set_param(blk,'u_gas_at_T_ref',u_gas_at_T_ref_str);


