function blk_clausius_clapeyron(blk)

%% Simulink block callback.
% Block name: blk_clausius_clapeyron

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% December 2018

%%
% NOTE: Everything that is writen here will go to MaskInitialization parameter

% Get mask parameters:
par1 = get_param(blk,'sel_1');
par2 = get_param(blk,'sel_2');

c = conversion_factors();

% Unversal gas constant:
R = c.R; % J/K/mol

% Select Pair type:
switch par2
    case 'BaCl2/NH3'
        data = get_material_properties('Barium chloride/Ammonia (BaCl2/NH3)');
        P0 = data.Pref_r;   % bar
        dH = data.dh_r;     % J/mol
        dS = data.ds_r;     % J/K/mol
    case 'NH3(liquid)/NH3(gas)'
        data = get_material_properties('Ammonia gas (NH3)');
        P0 = data.Pref_bar; % bar
        dH = data.dh;       % J/mol
        dS = data.ds;       % J/K/mol
end

% Define function according to pair type and input/output selected:
switch par1
    case 'P(T)'
        in1 = '(K)';
        out1 = '(bar)';
        fun = [num2str(P0),' * exp(',num2str(-dH/R),'/u(1) + ',num2str(dS/R),')'];
    case 'T(P)'
        in1 = '(bar)';
        out1 = '(K)';
        fun = [num2str(dH/R),'/(',num2str(dS/R),' - log(u(1)/',num2str(P0),'))'];
end

% Change name of input:
p = get_param([blk,'/In1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in1);

% Change name of output:
p = get_param([blk,'/Fcn'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);

% Set 'Fcn' bloc' function string:
set_param([blk,'/Fcn'],'Expr',fun)

% Set mask title and port labels:
% 1) Define string for 'MaskDisplay' parameter:
MaskDisplay_string1 = ['disp(''',par2,'''); '];
MaskDisplay_string2 = ['port_label(''input'',1,''',in1,'''); '];
MaskDisplay_string3 = ['port_label(''output'',1,''',out1,'''); '];
MaskDisplay_string = [MaskDisplay_string1 MaskDisplay_string2 MaskDisplay_string3];

% 2) Set parameter:
set_param(blk,'MaskDisplay',MaskDisplay_string);
