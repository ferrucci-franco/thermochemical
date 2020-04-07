function blk_thermodynamic_properties_nonsaturated_interpreted(blk)

%% Simulink block callback.
% Block name: blk_thermodynamic_properties_nonsaturated_interpreted

% This function is used to update a mask parameter when the user change
% some mask parameter value.

% Franco Ferrucci
% ferruccifranco@gmail.com
% April 2019

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
    case 'v(T,P)'    
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'v (m³/mol)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '+1';
    case 'rho(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'h(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'h (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 's (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
	case 'cp(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cv(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'phase(T,P)'
        in1 = 'T (K)';
        in2 = 'P (bar)';
        out1 = 'phase';
        str_function = '''Phase''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
	case 'T(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'T (K)';
        str_function = '''T''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'v(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'v (m3/mol)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '+1';
    case 'rho(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 's (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cp(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cv(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'phase(h,P)'
        in1 = 'h (J/mol)';
        in2 = 'P (bar)';
        out1 = 'phase';
        str_function = '''Phase''';
        str = [str_prefix_par, str_function,',',...
               '''Hmolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
	case 'T(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'T (K)';
        str_function = '''T''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'v(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'v (m3/mol)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '+1';      
    case 'rho(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'rho (mol/m³)';
        str_function = '''Dmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'u (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'h(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'h (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cp(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'cp (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cv(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'cv (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'beta (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'kappa (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'phase(s,P)'
        in1 = 's (J/K/mol)';
        in2 = 'P (bar)';
        out1 = 'phase';
        str_function = '''Phase''';
        str = [str_prefix_par, str_function,',',...
               '''Smolar''',',','u(1)',',',...
               '''P''',',','u(2)','*',num2str(c.bar_to_Pa),',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'P(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'P (bar)';
        str_function = '''P''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,')*',num2str(c.Pa_to_bar),';'];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'h(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'h (J/mol)';
        str_function = '''Hmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'u(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'u (J/mol)';
        str_function = '''Umolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 's(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 's (J/K/mol)';
        str_function = '''Smolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cp(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'cp (J/K/mol)';
        str_function = '''Cpmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'cv(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'cv (J/K/mol)';
        str_function = '''Cvmolar''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'beta(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'beta (1/K)';
        str_function = '''isobaric_expansion_coefficient''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';
    case 'kappa(T,rho)'
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'kappa (1/Pa)';
        str_function = '''isothermal_compressibility''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
               str_fluid,str_sufix_par];
        set_param([blk,'/Subsystem1/CoolProp_function_call'],'MATLABFcn',str);
        reciproc = '-1';        
    case 'phase(T,rho)' 
        in1 = 'T (K)';
        in2 = 'rho (mol/m³)';
        out1 = 'phase';
        str_function = '''Phase''';
        str = [str_prefix_par, str_function,',',...
               '''T''',',','u(1)',',',...
               '''Dmolar''',',','u(2)',',',...
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

%% Change name of input 2:
p = get_param([blk,'/In2'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',in2);
set_param([blk,'/In2'],'IconDisplay','Signal name');

%% Change name of output:
p = get_param([blk,'/Subsystem1'],'PortHandles');
q = get_param(p.Outport,'Line');
set_param(q,'Name',out1);