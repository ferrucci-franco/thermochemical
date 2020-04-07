function blk_thermodynamic_properties_saturated_interpreted(blk)

%% Simulink block callback.
% Block name: blk_thermodynamic_properties_saturated_interpreted

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% August 2019

%% Load conversion factor struct variable:
c = conversion_factors();

%% Get mask parameters:
par = get_param(blk,'sel');
fluid = get_param(blk,'fluid');
ref = get_param(blk,'ref');

%% Switch over 'ref':
str_fluid = ['''',fluid,''''];
str_prefix_ref = 'CoolProp.set_reference_stateS(';
str_sufix_ref = ')';

switch ref
    case 'NBP: h=0, s=0 for saturated liquid at 1 atmosphere'
        str_function = '''NBP''';
    case 'IIR: h = 200 kJ/kg, s=1 kJ/kg/K at 0C saturated liquid'
        str_function = '''IIR''';
	case 'ASHRAE: h = 0, s = 0 @ -40C saturated liquid'
        str_function = '''ASHRAE''';
    otherwise
        error('It shouldn''t have gotten in her!')
end   
str = [str_prefix_ref, str_fluid,',',str_function,str_sufix_ref];
disp(str)
eval(str)

%% Switch over 'par':
str_prefix_par = 'CoolProp.PropsSI(';
str_sufix_par = ');';

switch par
    case 'P(T) (bar)'
        in1 = 'T (K)';
        out1 = 'P(T) (bar)';
        str_function = '''P''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0.5,',...
               str_fluid,')*',num2str(c.Pa_to_bar),';'];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'h(T) liq. (J/mol)'
        in1 = 'T (K)';
        out1 = 'h(T) liq. (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'h(T) vap. (J/mol)'
        in1 = 'T (K)';
        out1 = 'h(T) vap. (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(T) liq. (J/mol)'
        in1 = 'T (K)';
        out1 = 'u(T) liq. (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(T) vap. (J/mol)'
        in1 = 'T (K)';
        out1 = 'u(T) vap. (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 's(T) liq. (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 's(T) vap. (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'rho(T) liq. (mol/m3)'
        in1 = 'T (K)';
        out1 = 'rho(T) liq. (mol/m3)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
     case 'rho(T) vap. (mol/m3)'
        in1 = 'T (K)';
        out1 = 'rho(T) vap. (mol/m3)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cp(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cp(T) liq. (J/K/mol)';        
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cp(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cp(T) vap. (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cv(T) liq. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cv(T) liq. (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cv(T) vap. (J/K/mol)'
        in1 = 'T (K)';
        out1 = 'Cv(T) vap. (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(T) liq. (1/K)'
        in1 = 'T (K)';
        out1 = 'beta(T) liq. (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(T) vap. (1/K)'
        in1 = 'T (K)';
        out1 = 'beta(T) vap. (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(T) liq. (1/Pa)'
        in1 = 'T (K)';
        out1 = 'kappa(T) liq. (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(T) vap. (1/Pa)'
        in1 = 'T (K)';
        out1 = 'kappa(T) vap. (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'T(P) (K)'
        in1 = 'P (bar)';
        out1 = 'T (K)';
        str_function = '''T''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0.5,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';        
    case 'h(P) liq. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'h(P) liq. (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';          
    case 'h(P) vap. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'h(P) vap. (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';          
    case 'u(P) liq. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'u(P) liq. (J/mol)';        
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(P) vap. (J/mol)'
        in1 = 'P (bar)';
        out1 = 'u(P) vap. (J/mol)';        
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 's(P) liq. (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 's(P) vap. (J/K/mol)';        
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'rho(P) liq. (mol/m3)'
        in1 = 'P (bar)';
        out1 = 'rho(P) liq. (mol/m3)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'rho(P) vap. (mol/m3)'
        in1 = 'P (bar)';
        out1 = 'rho(P) vap. (mol/m3)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cp(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cp(P) liq. (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cp(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cp(P) vap. (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cv(P) liq. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cv(P) liq. (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'Cv(P) vap. (J/K/mol)'
        in1 = 'P (bar)';
        out1 = 'Cv(P) vap. (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(P) liq. (1/K)'
        in1 = 'P (bar)';
        out1 = 'beta(P) liq. (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(P) vap. (1/K)'
        in1 = 'P (bar)';
        out1 = 'beta(P) vap. (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(P) liq. (1/Pa)'
        in1 = 'P (bar)';
        out1 = 'kappa(P) liq. (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',0,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(P) vap. (1/Pa)'
        in1 = 'P (bar)';
        out1 = 'kappa(P) vap. (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''P''',',','u(1)*',num2str(c.bar_to_Pa),',',...
               '''Q'',1,',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    otherwise
        error('It shouldn''t have gotten in her!')
end

%% Update mask parameters (some are used in the Initialization tab):
set_param(blk,'reciprocVar',reciproc); % switch position

%% Change name of input 1:
p = get_param([blk,'/In1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in1);
set_param([blk,'/In1'],'IconDisplay','Signal name');

%% Change name of output:
p = get_param([blk,'/Subsystem1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);