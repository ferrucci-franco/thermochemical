function blk_wall_simple(blk)

%% Simulink block callback.
% Block name: wall_simple

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% Jan 2018

%% Get mask parameters:
metal_str = get_param(blk,'material');
enable_cell = get_param(blk,'MaskEnables');
rho = get_param_eval(blk,'rho');
cp = get_param_eval(blk,'cp');
e_mm = get_param_eval(blk,'e_mm');
s = get_param_eval(blk,'s');

%% Get metal density and cp:
if strcmp(metal_str,'Custom')
    % Enable 'cp' and 'rho' text parameters:
    enable_cell{2} = 'on';
    enable_cell{3} = 'on';
    set_param(blk,'MaskEnables',enable_cell);
else
    % Disable 'cp' and 'rho' text parameters:
    enable_cell{2} = 'off';
    enable_cell{3} = 'off';
    set_param(blk,'MaskEnables',enable_cell);
    
    % Retreive material information:
    metal = get_material_properties(metal_str);
    cp = metal.cp;
    rho = metal.rho;
end

%% Compute mass:
m = num2str(rho*e_mm/1000*s);

%% Convert to string
m_str = num2str(m);
cp_str = num2str(cp);
rho_str = num2str(rho);

%% Set parameters
set_param(blk,'mass',m_str);
set_param(blk,'cp',cp_str);
set_param(blk,'rho',rho_str);
