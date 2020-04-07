function blk_wall_finned_tube(blk)

%% Simulink block callback.
% Block name: wall_finned_tube

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% March 2018

%% Get mask parameters
tube_material = get_param(blk,'material_tube');
fin_material = get_param(blk,'material_fin');
L_m = get_param_eval(blk,'L_m');
OD_mm = get_param_eval(blk,'OD_mm');
e_mm = get_param_eval(blk,'e_mm');
rho_tube = get_param_eval(blk,'rho_tube');
cp_tube = get_param_eval(blk,'cp_tube');
height_fin_mm = get_param_eval(blk,'height_fin_mm');
e_fin_mm = get_param_eval(blk,'thickness_fin_mm');
pitch_fin_mm = get_param_eval(blk,'pitch_fin_mm');
rho_fin = get_param_eval(blk,'rho_fin');
cp_fin = get_param_eval(blk,'cp_fin');
lambda_fin = get_param_eval(blk,'lambda_fin');

% Get cell of 'enables':
enable_cell = get_param(blk,'MaskEnables');

%% Get 'Popup' mask parameters
% Get tube rho and cp:
if strcmp(tube_material,'Custom')
    % Enable 'cp' and 'rho' text parameters:
    enable_cell{5} = 'on';
    enable_cell{6} = 'on';
else
    % Disable 'cp' and 'rho' text parameters:
    enable_cell{5} = 'off';
    enable_cell{6} = 'off';
   
    % Replace cp and rho with retreived material information:
    metal_tube = get_material_properties(tube_material);
    cp_tube = metal_tube.cp;
    rho_tube = metal_tube.rho;
end

% Get fin rho and cp:
if strcmp(fin_material,'Custom')
    % Enable 'cp' and 'rho' text parameters:
    enable_cell{11} = 'on';
    enable_cell{12} = 'on';
    enable_cell{13} = 'on';
else
    % Disable 'cp' and 'rho' text parameters:
    enable_cell{11} = 'off';
    enable_cell{12} = 'off';
    enable_cell{13} = 'off';
   
    % Replace cp, rho and lambda with retreived material information:
    metal_fin = get_material_properties(fin_material);
    cp_fin = metal_fin.cp;
    rho_fin = metal_fin.rho;
    lambda_fin = metal_fin.k;
end

%% Compute mass of tube and fins
[kg_tube, kg_fins, m2_inner, m2_outer] = blk_wall_finned_tube_fun1(OD_mm, e_mm, L_m, rho_tube, height_fin_mm, pitch_fin_mm, e_fin_mm, rho_fin);
kg_total = kg_tube + kg_fins;

%% Convert num to string
cp_tube_str = num2str(cp_tube);
rho_tube_str = num2str(rho_tube);
cp_fin_str = num2str(cp_fin);
rho_fin_str = num2str(rho_fin);
kg_tube_str = num2str(kg_tube);
kg_fins_str = num2str(kg_fins);
kg_total_str = num2str(kg_total);
m2_inner_str = num2str(m2_inner);
m2_outer_str = num2str(m2_outer);
lambda_fin_str = num2str(lambda_fin);

%% Set parameters
set_param(blk,'MaskEnables',enable_cell);
set_param(blk,'cp_tube',cp_tube_str);
set_param(blk,'rho_tube',rho_tube_str);
set_param(blk,'cp_fin',cp_fin_str);
set_param(blk,'rho_fin',rho_fin_str);
set_param(blk,'mass_tube',kg_tube_str);
set_param(blk,'mass_fin',kg_fins_str);
set_param(blk,'mass_total',kg_total_str);
set_param(blk,'s_inner',m2_inner_str);
set_param(blk,'s_outer',m2_outer_str);
set_param(blk,'lambda_fin',lambda_fin_str);
