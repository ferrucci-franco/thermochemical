function blk_cold_room_closed_dry_air(blk)

%% Simulink block callback.
% Block name: room_closed_dry_air

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2018

%% Get mask parameters:
L = get_param_eval(blk,'L');
W = get_param_eval(blk,'W');
H = get_param_eval(blk,'H');
Tinit_C = get_param_eval(blk,'Tinit_C');

%% Parameters computation:
c = conversion_factors();
%
sup = (2*L+2*W)*H + 2*L*W;
vol = L*W*H;
rho_init = CoolProp.PropsSI('Dmass','T',c.C_to_K(Tinit_C),'P',1*c.atm_to_Pa,'Air');
m_dry_air = rho_init * vol;
cv_dry_air = CoolProp.PropsSI('Cvmass','T',300,'P',1*c.atm_to_Pa,'Air');

%% Convert num to string
S_str = num2str(sup);
V_str = num2str(vol);
m_dry_air_str = num2str(m_dry_air);
cv_dry_air_str = num2str(cv_dry_air);

%% Update mask parameters
set_param(blk,'S',S_str);
set_param(blk,'V',V_str);
set_param(blk,'M',m_dry_air_str);
set_param(blk,'Cv',cv_dry_air_str);

