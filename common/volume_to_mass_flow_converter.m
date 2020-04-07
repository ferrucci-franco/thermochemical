function mass_flow_out = volume_to_mass_flow_converter(vol_flow_in, unit_in, unit_out, TP, fluidName)

% volume_to_mass_flow_converter    Volume flow to mass flow converter
% 
% Use:
%     mass_flow_out =volume_to_mass_flow_converter(volume_flow_in, unit_in, unit_out, TP, fluidName)
% with:
%    - vol_flow_in: volume flow (numeric value)
%    - unit_in: units of the input 'volume_flow_in'
%    - unit_out: units of the function output
%    - TP: temperature (°C) and pressure(bar) condition of the fluid.
%    - fluidName: name of the fluid.
% 
% The possible units for input volume flow are: 
%    'L/sec'
%    'L/min'
%    'L/h'
%    'm3/sec'
%    'm3/min'
%    'm3/h'
%    'cfm' (cubit feet per minute)
%
% The possible units for output mass flow are: 
%    'mol/sec', 
%    'mol/min', 
%    'mol/h', 
%    'kg/sec',
%    'kg/min', 
%    'kg/h'
% 
% The 'TP' argument can be either a string or a vector with two values.
% If a string is passed, it must be one of the followings:
%    'STP'  --> Standard temperature and pressure (0ºC, 1 bar)
%    'NTP'  --> Normal temperature and pressure (20ºC, 1 bar)
% If a vector is pass, they must be the temperature (in ºC) and 
% pressure (in bar absolute) of the fluid: [T, P] or [T; P]
% 
% To get a list of accepted fluids, please run the following funtion:
%     CoolProp.get_global_param_string('FluidsList')
% 
% Examples of use:
%    flow_out = volume_to_mass_flow_converter(10, 'L/min', 'mol/sec', 'STP', 'Air')
%    flow_out = volume_to_mass_flow_converter(10, 'L/min', 'mol/sec','NTP', 'R134a')
%    flow_out = volume_to_mass_flow_converter(10, 'm3/sec', 'kg/h', [35 2.5], 'Ammonia')
%
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% March 2017

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
addRequired(p,'vol_flow_in',@(x) isnumeric(x) && x > 0);

% 2nd input:
expectedUnits = {'L/sec','L/min','L/h','m3/sec','m3/min','m3/h','cfm'};
addRequired(p,'unit_in',@(x) any(validatestring(x,expectedUnits)));

% 3rd input:
expectedUnits = {'mol/sec','mol/min','mol/h','kg/sec','kg/min','kg/h'};
addRequired(p,'unit_out',@(x) any(validatestring(x,expectedUnits)));

% 4th input:
expectedPT = {'STP','NTP'};
validatePT = @(x) (ischar(x) && any(validatestring(x,expectedPT))) || ...
                  (isnumeric(x) && isvector(x) && numel(x) == 2 && x(2) > 0);
addRequired(p,'PT', validatePT);
     
% 5th input:
expectedFluid = strsplit(CoolProp.get_global_param_string('FluidsList'),',');
validateFluid = @(x) ischar(x) && any(validatestring(x,expectedFluid));
addRequired(p, 'fluid', validateFluid);

% Run the parsing to check inputs:
parse(p, vol_flow_in, unit_in, unit_out, TP, fluidName)

%% Constants
% bar to Pa:
bar_to_Pa = 1e5;

% 0ºC to K:
Tkelvin = 273.15; 

%% Fluid Pressure and Temperature
if ~isnumeric(p.Results.PT)
    switch p.Results.PT
        case 'STP'
            T_C = 0;
            P_bar = 1;
        case 'NTP'
            T_C = 20;
            P_bar = 1;
        otherwise
        error('ERROR. The function should not have gotten in here!')
    end
else
    T_C = p.Results.PT(1);
    P_bar = p.Results.PT(2);
end
    
%% Conversion
% Volume flow units converter:
m3_sec = volume_flow_converter(vol_flow_in, unit_in, 'm3/sec');

% Volume flow to mass flow:
mol_sec = m3_sec * CoolProp.PropsSI('Dmolar', ...
                                    'P',P_bar * bar_to_Pa, ...
                                    'T',T_C + Tkelvin, ...
                                    fluidName); % [m3/sec]
                                
% m3/sec to output volume flow:                            
mass_flow_out = mass_flow_converter(mol_sec, 'mol/sec', unit_out, fluidName);
return
