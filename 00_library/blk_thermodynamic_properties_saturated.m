function blk_thermodynamic_properties_saturated(blk)

%% Simulink block callback.
% Block name: blk_thermodynamic_properties_saturated

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2018

%% 
% Get mask parameters:
par = get_param(blk,'sel');
fluid = get_param(blk,'fluid');

switch par
    case 'P(T) (bar)'
        in1 = 'T (K)';
        out1 = 'P(T) (bar)';
        breakPoint1 = 'sat.T';
        data =        'sat.Psat';
    case 'h(T) liq. (J/mol)'
        in1 = 'T (K)';
        out1 = 'h(T) liq. (J/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.h_molar';
    case 'h(T) vap. (J/mol)'
        in1 = 'T (K)';
        out1 = 'h(T) vap. (J/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.h_molar';
    case 'u(T) liq. (J/mol)'
        in1 = 'T (K)';
        out1 = 'u(T) liq. (J/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.u_molar';
    case 'u(T) vap. (J/mol)'
        in1 = 'T (K)';
        out1 = 'u(T) vap. (J/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.u_molar';
    case 's(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 's(T) liq. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.s_molar';
    case 's(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 's(T) vap. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.s_molar';
    case 'rho(T) liq. (mol/m3)'
        in1 = 'T (K)';
        out1 = 'rho(T) liq. (mol/m3)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.rho_molar';
    case 'rho(T) vap. (mol/m3)'
        in1 = 'T (K)';
        out1 = 'rho(T) vap. (mol/m3)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.rho_molar';
    case 'Cp(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cp(T) liq. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.Cp_molar';
    case 'Cp(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cp(T) vap. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.Cp_molar';
    case 'Cv(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cv(T) liq. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.Cv_molar';
    case 'Cv(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cv(T) vap. (J/K/mol)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.Cv_molar';
    case 'beta(T) liq. (1/K)'
        in1 = 'T (K)';
        out1 = 'beta(T) liq. (1/K)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.beta';
    case 'beta(T) vap. (1/K)'
        in1 = 'T (K)';
        out1 = 'beta(T) vap. (1/K)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.beta';  
    case 'kappa(T) liq. (1/Pa)'
        in1 = 'T (K)';
        out1 = 'kappa(T) liq. (1/Pa)';
        breakPoint1 = 'sat.T';
        data =        'sat.liq.kappa';
    case 'kappa(T) vap. (1/Pa)'
        in1 = 'T (K)';
        out1 = 'kappa(T) vap. (1/Pa)';
        breakPoint1 = 'sat.T';
        data =        'sat.vap.kappa';
    %
    case 'T(P) (K)'
        in1 = 'P (bar)';
        out1 = 'T (K)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.T';
    case 'h(P) liq. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'h(P) liq. (J/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.h_molar';
    case 'h(P) vap. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'h(P) vap. (J/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.h_molar';
    case 'u(P) liq. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'u(P) liq. (J/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.u_molar';
    case 'u(P) vap. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'u(P) vap. (J/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.u_molar';
    case 's(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 's(P) liq. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.s_molar';
    case 's(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 's(P) vap. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.s_molar';
    case 'rho(P) liq. (mol/m3)'
        in1 = 'P (bar)';
        out1 = 'rho(P) liq. (mol/m3)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.rho_molar';
    case 'rho(P) vap. (mol/m3)'
        in1 = 'P (bar)';
        out1 = 'rho(P) vap. (mol/m3)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.rho_molar';
    case 'Cp(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cp(P) liq. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.Cp_molar';
    case 'Cp(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cp(P) vap. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.Cp_molar';
    case 'Cv(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cv(P) liq. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.liq.Cv_molar';
    case 'Cv(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cv(P) vap. (J/K/mol)';
        breakPoint1 = 'sat.Psat';
        data =        'sat.vap.Cv_molar';
    case 'beta(P) liq. (1/K)'
        in1 = 'P (bar)';
        out1 = 'beta(P) liq. (1/K)';
        breakPoint1 = 'sat.P';
        data =        'sat.liq.beta';
    case 'beta(P) vap. (1/K)'
        in1 = 'P (bar)';
        out1 = 'beta(P) vap. (1/K)';
        breakPoint1 = 'sat.P';
        data =        'sat.vap.beta';  
    case 'kappa(P) liq. (1/Pa)'
        in1 = 'P (bar)';
        out1 = 'kappa(P) liq. (1/Pa)';
        breakPoint1 = 'sat.P';
        data =        'sat.liq.kappa';
    case 'kappa(P) vap. (1/Pa)'
        in1 = 'P (bar)';
        out1 = 'kappa(P) vap. (1/Pa)';
        breakPoint1 = 'sat.P';
        data =        'sat.vap.kappa';        
    otherwise
        error('It shouldn''t have gotten in her!')
end

% Set mask parameters:
set_param(blk,'lookup1D_Data',[fluid,'.',data]);
set_param(blk,'lookup1D_BreakPoint1',[fluid,'.',breakPoint1]);

% Change name of input:
p = get_param([blk,'/In1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in1);

% Change name of output:
p = get_param([blk,'/Subsystem1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);
