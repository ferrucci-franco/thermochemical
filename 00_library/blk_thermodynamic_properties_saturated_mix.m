function blk_thermodynamic_properties_saturated_mix(blk)

%% Simulink block callback.
% Block name: blk_thermodynamic_properties_saturated

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2018

%% Get mask parameters:
par = get_param(blk,'sel');
fluid = get_param(blk,'fluid');

switch par
    case 'h(T) (J/mol)'
        out1 = 'h(T) mix (J/mol)';
        data1 =      'sat.liq.h_molar';
        data2 =      'sat.vap.h_molar';
    case 'u(T) (J/mol)'
        out1 = 'u(T) mix (J/mol)';
        data1 =      'sat.liq.u_molar';
        data2 =      'sat.vap.u_molar';        
    case 's(T) (J/K/mol)'
        out1 = 's(T) mix (J/K/mol)';
        data1 =      'sat.liq.s_molar';
        data2 =      'sat.vap.s_molar';
    case 'rho(T) (mol/m3)'
        out1 = 'rho(T) mix (mol/m3)';
        data1 =      'sat.liq.rho_molar';
        data2 =      'sat.vap.rho_molar';
    case 'cp(T) (J/K/mol)'
        out1 = 'cp(T) mix (J/K/mol)';
        data1 =      'sat.liq.cp_molar';
        data2 =      'sat.vap.cp_molar';
    case 'cv(T) (J/K/mol)'
        out1 = 'cv(T) mix (J/K/mol)';
        data1 =      'sat.liq.cv_molar';
        data2 =      'sat.vap.cv_molar';
    otherwise
        error('It shouldn''t have gotten in her!')
end
%% Set mask parameters:
set_param(blk,'lookup1D_Data1',[fluid,'.',data1]);
set_param(blk,'lookup1D_Data2',[fluid,'.',data2]);

%% Change name of output:
p = get_param([blk,'/Subsystem1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);
