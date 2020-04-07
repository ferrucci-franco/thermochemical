function vel_out = mass_to_speed_flow_converter(mass_flow_in, unit_in, unit_out, TP, diam, diam_unit, fluidName)

% mass_to_speed_flow_converter    Mass flow to speed flow converter for a
%                                 cylindrical pipe
% 
% Use:
%     mass_to_speed_flow_converter(mass_flow_in, unit_in, unit_out, TP, diam, diam_unit, fluidName)
% with:
%    - mass_flow_in: mass flow (numeric value)
%    - unit_in: units of the input 'mass_flow_in'
%    - unit_out: units of the function output
%    - TP: temperature (°C) and pressure(bar) condition of the fluid.
%    - diam: inner diameter (I.D.) of pipe 
%    - diam_unit: units of 'diam' (inch, mm)
%    - fluidName: name of the fluid.
% 
% The possible units for input mass flow are: 
%    'mol/sec', 
%    'mol/min', 
%    'mol/h', 
%    'kg/sec',
%    'kg/min', 
%    'kg/h'
% 
% The possible units for output fluid velocity are: 
%    'm/sec'
%    'ft/sec'
%    'km/h'
% 
% The 'TP' argument can be either a string or a vector with two values.
% If a string is passed, it must be one of the followings:
%    'STP'  --> Standard temperature and pressure (0ºC, 1 bar)
%    'NTP'  --> Normal temperature and pressure (20ºC, 1 bar)
% If a vector is pass, they must be the temperature (in ºC) and 
% pressure (in bar absolute) of the fluid: [T, P] or [T; P]
% 
% The possible units for 'diam' (diameter) are:
%    'mm'
%    'inch'
%    'm'
%
% To get a list of accepted fluids, please run the following funtion:
%     CoolProp.get_global_param_string('FluidsList')
% 
% Example of use:
%    vel_out = mass_to_speed_flow_converter(1, 'kg/sec', 'km/h', [25,2], 10,'mm','Water')
%    vel_out = mass_to_speed_flow_converter(10, 'kg/h', 'm/sec', [25,17], 4,'mm','Ammonia')
%
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% June 2018

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
addRequired(p,'mass_flow_in',@(x) isnumeric(x) && x > 0);

% 2nd input:
expectedUnits = {'mol/sec','mol/min','mol/h','kg/sec','kg/min','kg/h'};
addRequired(p,'unit_in',@(x) any(validatestring(x,expectedUnits)));

% 3rd input:
expectedUnits = {'m/sec','ft/sec','km/h'};
addRequired(p,'unit_out',@(x) any(validatestring(x,expectedUnits)));

% 4th input:
expectedPT = {'STP','NTP'};
validatePT = @(x) (ischar(x) && any(validatestring(x,expectedPT))) || ...
                  (isnumeric(x) && isvector(x) && numel(x) == 2 && x(2) > 0);
addRequired(p,'PT', validatePT);
     
% 5th input:
addRequired(p,'diam',@(x) isnumeric(x) && x > 0);
     
% 6th input:
expectedUnits = {'mm','inch','m'};
addRequired(p,'diam_unit',@(x) any(validatestring(x,expectedUnits)));

% 7th input:
expectedFluid = strsplit(CoolProp.get_global_param_string('FluidsList'),',');
validateFluid = @(x) ischar(x) && any(validatestring(x,expectedFluid));
addRequired(p, 'fluid', validateFluid);

% Run the parsing to check inputs:
parse(p, mass_flow_in, unit_in, unit_out, TP, diam, diam_unit, fluidName);

%% Conversion factors
c = conversion_factors();

%% Unit identification 
% Flow in units:
mol_sec = mass_flow_converter(mass_flow_in, unit_in, 'mol/sec', fluidName);

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
    
%% Mass flow to volume flow:
m3_sec = mol_sec / CoolProp.PropsSI('Dmolar', ...
                                    'P',P_bar * c.bar_to_Pa, ...
                                    'T',T_C + c.Tk, ...
                                    fluidName); % [m3/sec]
 
%% Volume flow to velocity (m/sec)                              
switch p.Results.diam_unit
    case 'mm'
        diam_m = p.Results.diam * c.mm_to_m;
    case 'inch'
        diam_m = p.Results.diam * c.in_to_m;
    case 'm'
        diam_m = p.Results.diam * 1;
    otherwise
        error('ERROR. The function should not have gotten in here!')
end

% Axial surface computation (m2):
sup_m2 = pi * diam_m^2 / 4;

% Velocity (m/sec)
vel_m_sec = m3_sec / sup_m2;

%% m/sec to output velocity
switch p.Results.unit_out
    case 'm/sec'
        K = 1;
    case 'ft/sec'
        K = c.m_to_ft;
    case 'km/h'
        K = c.m_sec_to_km_h;
    otherwise
        error('ERROR. The function should not have gotten in here!')
end
vel_out = K * vel_m_sec;

return
