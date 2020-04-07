function blk_thermodynamic_properties_nonsaturated(blk)

%% Simulink block callback.
% Block name: thermodynamic_properties_nonsaturated

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2018

%% Get mask parameters:
par = get_param(blk,'sel');
fluid = get_param(blk,'fluid');

switch par
    case 'v(T,P)'    
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'v (m³/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.rho_molar';
        reciproc = '+1';
    case 'rho(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.rho_molar';
        reciproc = '-1';
    case 'h(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'h (J/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.h_molar';
        reciproc = '-1';
    case 'u(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.u_molar';
        reciproc = '-1';
    case 's(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 's (J/K/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.s_molar';
        reciproc = '-1';
	case 'cp(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.Cp_molar';
        reciproc = '-1';
    case 'cv(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.Cv_molar';
        reciproc = '-1';
    case 'beta(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.beta';
        reciproc = '-1';
    case 'kappa(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.kappa';
        reciproc = '-1';
    case 'phase(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'phase';
        breakPoint1 = 'no_sat.T_P_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_P_indep.var_indep.P';
        data =        'no_sat.T_P_indep.var_dep.phase';
        reciproc = '-1';
	case 'T(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'T (K)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.T';
        reciproc = '-1';
    case 'v(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'v (m3/mol)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.rho_molar';
        reciproc = '+1';
    case 'rho(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.rho_molar';
        reciproc = '-1';
    case 'u(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.u_molar';
        reciproc = '-1';
    case 's(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 's (J/K/mol)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.s_molar';
        reciproc = '-1';
    case 'cp(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.Cp_molar';
        reciproc = '-1';
    case 'cv(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.Cv_molar';
        reciproc = '-1';
    case 'beta(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.beta';
        reciproc = '-1';
    case 'kappa(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.kappa';
        reciproc = '-1';
    case 'phase(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'phase';
        breakPoint1 = 'no_sat.h_P_indep.var_indep.h_molar';
        breakPoint2 = 'no_sat.h_P_indep.var_indep.P';
        data =        'no_sat.h_P_indep.var_dep.phase';
        reciproc = '-1';
	case 'T(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'T (K)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.T';
        reciproc = '-1';
    case 'v(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'v (m3/mol)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.rho_molar';
        reciproc = '+1';      
    case 'rho(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.rho_molar';
        reciproc = '-1';
    case 'u(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.u_molar';
        reciproc = '-1';
    case 'h(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'h (J/mol)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.h_molar';
        reciproc = '-1';
    case 'cp(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.Cp_molar';
        reciproc = '-1';
    case 'cv(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.Cv_molar';
        reciproc = '-1';
    case 'beta(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.beta';
        reciproc = '-1';
    case 'kappa(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.kappa';
        reciproc = '-1';
    case 'phase(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'phase';
        breakPoint1 = 'no_sat.s_P_indep.var_indep.s_molar';
        breakPoint2 = 'no_sat.s_P_indep.var_indep.P';
        data =        'no_sat.s_P_indep.var_dep.phase';
        reciproc = '-1';
    case 'P(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'P (bar)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.P';
        reciproc = '-1';
    case 'h(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'h (J/mol)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.h_molar';
        reciproc = '-1';
    case 'u(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'u (J/mol)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.u_molar';
        reciproc = '-1';
    case 's(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 's (J/K/mol)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.s_molar';
        reciproc = '-1';
    case 'cp(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'cp (J/K/mol)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.Cp_molar';
        reciproc = '-1';
    case 'cv(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'cv (J/K/mol)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.Cv_molar';
        reciproc = '-1';
    case 'beta(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'beta (1/K)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.beta';
        reciproc = '-1';
    case 'kappa(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'kappa (1/Pa)';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.kappa';
        reciproc = '-1';        
    case 'phase(T,rho)' 
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'phase';
        breakPoint1 = 'no_sat.T_rho_indep.var_indep.T';
        breakPoint2 = 'no_sat.T_rho_indep.var_indep.rho_molar';
        data =        'no_sat.T_rho_indep.var_dep.phase';
        reciproc = '-1';
    otherwise
        error('It shouldn''t have gotten in her!')
end

%% Update mask parameters (some are used in the Initialization tab):
set_param(blk,'reciprocVar',reciproc); % switch position
set_param(blk,'lookup2D_Data',[fluid,'.',data]); % loo-up table
set_param(blk,'lookup2D_BreakPoint1',[fluid,'.',breakPoint1]); % look-up table
set_param(blk,'lookup2D_BreakPoint2',[fluid,'.',breakPoint2]); % look-up table

%% Change name of input 1:
p = get_param([blk,'/In1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in1);

%% Change name of input 2:
p = get_param([blk,'/In2'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in2);
set_param([blk,'/In2'],'IconDisplay','Signal name');

%% Change name of output:
p = get_param([blk,'/Subsystem1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);
