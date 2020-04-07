function flow_out = mass_flow_converter(flow_in, unit_in, unit_out, fluid_name_or_molar_mass)

% mass_flow_converter     Mass flow units converter
% 
% Use:
%    flow_out = mass_flow_converter(flow_in, unit_in, unit_out, fluid_name_or_molar_mass)
% 
% The possible units (either for intput or output flow) are: 
%    'mol/sec', 
%    'mol/min', 
%    'mol/h', 
%    'kg/sec',
%    'kg/min', 
%    'kg/h'
% 
% As for the last parameter, it can be either a string with the fluid name
% or a real number with the molar mass of the fluid (in kg/mol).
% 
% To get a list of accepted fluids, please run the following funtion:
%     CoolProp.get_global_param_string('FluidsList')
% 
% Examples:
%    x = mass_flow_converter(1, 'mol/sec', 'kg/h', 'Ammonia')
%    x = mass_flow_converter(0.05, 'kg/sec', 'mol/min', 'CarbonDioxide')
%    x = mass_flow_converter(1.2, 'mol/sec', 'kg/h', 0.0125)
% 
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% March 2017

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
addRequired(p,'flow_in',@(x) isnumeric(x) && x >= 0);

% 2nd and 3rd inputs:
expectedUnits = {'mol/sec','mol/min','mol/h','kg/sec','kg/min','kg/h'};
addRequired(p,'unit_in',@(x) any(validatestring(x,expectedUnits)));
addRequired(p,'unit_out',@(x) any(validatestring(x,expectedUnits)));

% 4th input:
expectedFluid = strsplit(CoolProp.get_global_param_string('FluidsList'),',');
validateFluid = @(x) (ischar(x) && any(validatestring(x,expectedFluid)) || (isnumeric(x) && x > 0));
addRequired(p,'fluid_name_or_molar_mass', validateFluid);

parse(p, flow_in, unit_in, unit_out, fluid_name_or_molar_mass);

%% Fluid molar mass:
if isnumeric(p.Results.fluid_name_or_molar_mass)
    M = p.Results.fluid_name_or_molar_mass;
else
    M = CoolProp.Props1SI('M', p.Results.fluid_name_or_molar_mass);
end

%% Unit identification 
% Flow in units:
switch unit_in
    case 'mol/sec'
        idx_row = 1;
    case 'mol/min'
        idx_row = 2;
    case 'mol/h'
        idx_row = 3;
    case 'kg/sec'
        idx_row = 4;
    case 'kg/min'
        idx_row = 5;
    case 'kg/h'
        idx_row = 6;
    otherwise
        error('ERROR. The function should not have gotten in here!')
end
% Flow out units:
switch unit_out
    case 'mol/sec'
        idx_col = 1;
    case 'mol/min'
        idx_col = 2;
    case 'mol/h'
        idx_col = 3;
    case 'kg/sec'
        idx_col = 4;
    case 'kg/min'
        idx_col = 5;
    case 'kg/h'
        idx_col = 6;
	otherwise
        error('ERROR. The function should not have gotten in here!')
end

%% Conversion matrix
K = [   1,     60,   3600,      M, 60*M, 3600*M;...
     1/60,      1,     60,   M/60,    M,   60*M;...
   1/3600,   1/60,      1, M/3600, M/60,      M;...
      1/M,   60/M, 3600/M,      1,   60,   3600;...
   1/60/M,    1/M,   60/M,   1/60,    1,     60;...
 1/3600/M, 1/60/M,    1/M, 1/3600, 1/60,      1];

%% Conversion
flow_out = flow_in * K(idx_row,idx_col);
return

