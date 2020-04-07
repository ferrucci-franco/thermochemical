function y = valve_computation_liquid(type_out, val_in, type_in, Pin_bar, Pout_bar, Tin_C, fluidName)
% valve_computation_liquid    Valve parameter computation (with no flashing)
% 
% Use:
%     y = valve_computation_liquid(type_out, val_in, type_in, Pin_bar, Pout_bar, Tin_C, fluidName)
% with:
%    - type_out  : type or units of desired output
%    - val_in    : input value
%    - type_in   : type or units of input
%    - Pin_bar   : pressure (bara) at the valve inlet
%    - Pout_bar  : pressure (bara) at the valve outlet
%    - Tin_C     : temperature (°C) at the valve inlet
%    - fluidName : name of fluid
%
% The possible choices for 'type_in' and 'type_out' are:
%    'Cv' (Cv uses US GPM and psia)
%    'Kv' (Kv uses m3/h and bara)
%    'GPM'
%    'm3/h'
%
% To get a list of accepted fluids, please run the following funtion:
%     CoolProp.get_global_param_string('FluidsList')
% 
% Examples of use:
% Cv = valve_computation_liquid('Cv', 3, 'GPM', 5, 4, 60, 'Water')
% Cv = valve_computation_liquid('Cv', 6, 'm3/h', 20, 3, 50, 'Acetone')
% Kv = valve_computation_liquid('Kv', 3, 'GPM', 15, 10, 10, 'Ammonia')
% Kv = valve_computation_liquid('Kv', 7, 'm3/h', 15, 4, -10, 'Ammonia')
% flow = valve_computation_liquid('GPM',1.2, 'Cv', 15, 4, -5, 'Ammonia')
%
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% June 2018

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
expectedValues = {'Kv','Cv','GPM','m3/h'};
addRequired(p,'type_out',@(x) any(validatestring(x,expectedValues)));

% 2nd input:
addRequired(p,'val_in',@(x) isnumeric(x) && x > 0);

% 3rd input:
expectedValues = {'Kv','Cv','GPM','m3/h'};
addRequired(p,'type_in',@(x) any(validatestring(x,expectedValues)));

% 4th input:
addRequired(p,'Pin_bar',@(x) isnumeric(x) && x > 0);

% 5th input:
addRequired(p,'Pout_bar',@(x) isnumeric(x) && x > 0);

% 6th input:
addRequired(p,'Tin_C',@(x) isnumeric(x) && x > -273.15);

% 7th input:
expectedFluid = strsplit(CoolProp.get_global_param_string('FluidsList'),',');
validateFluid = @(x) ischar(x) && any(validatestring(x,expectedFluid));
addRequired(p, 'fluid', validateFluid);

% Run the parsing to check inputs:
parse(p, type_out, val_in, type_in, Pin_bar, Pout_bar, Tin_C, fluidName);

%% Conversion factors
c = conversion_factors();

% Cv <--> Kv conversion:
Cv_to_Kv = c.gpmUS_to_m3_h/sqrt(c.psi_to_bar);
Kv_to_Cv = 1/Cv_to_Kv;

% Water density computation (1atm, 15°C):
rho_water_kg_m3 = 1e3;

%% Fluid Pressure and Temperature
Pin_bar = p.Results.Pin_bar;
Pout_bar = p.Results.Pout_bar;
Tin_C = p.Results.Tin_C;

% Pressure difference:
dP_bar = Pin_bar - Pout_bar;
dP_psia = dP_bar * c.bar_to_psi;

% Fluid density computation (kg/m3):
rho_kg_m3 = CoolProp.PropsSI('DMASS', ...
                             'P', Pin_bar * c.bar_to_Pa, ...
                             'T', Tin_C + c.Tk, ...
                             fluidName);

% Specific gravity S.G. (referred to water):
SG = rho_kg_m3/rho_water_kg_m3;

%% Check if fluid inlet is in liquid state
% CoolProp phase index for liquid state:
phase_liquied_idx = CoolProp.get_phase_index('phase_liquid');

% Inlet phase:
phase_in = CoolProp.PropsSI('PHASE', ...
                            'P', Pin_bar * c.bar_to_Pa, ...
                            'T', Tin_C + c.Tk, ...
                            fluidName);
% Check:
if phase_in ~= phase_liquied_idx
    warning('Fluid is not liquid at valve inlet. Result might be wrong.')
end

%% Check if there is no flashing phenomenom (isenthalpic pressure drop):
% Saturation pressure 
Psat_bar = CoolProp.PropsSI('P','T', Tin_C + c.Tk,'Q',0,fluidName) * c.Pa_to_bar;

if phase_in == phase_liquied_idx && Pout_bar < Psat_bar
	warning('Flashing occurring! Result might be wrong.')
end

%% Output computation
switch p.Results.type_out
    case 'Cv'
        switch p.Results.type_in
            case 'GPM'
                GPM = p.Results.val_in;
            case 'm3/h'
                GPM = p.Results.val_in * c.m3_h_to_gpmUS;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        % Cv computation:
        Cv = GPM/sqrt(dP_psia/SG);
        % Return value assignment:
        y = Cv;
        
    case 'Kv'
        switch p.Results.type_in
            case 'GPM'
                Q_m3_h = p.Results.val_in * c.gpmUS_to_m3_h;
            case 'm3/h'
                Q_m3_h = p.Results.val_in;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        % Kv computation:
        Kv = Q_m3_h/sqrt(dP_bar/SG);
        % Return value assignment:
        y = Kv;
        
    case 'GPM'
        switch p.Results.type_in
            case 'Cv'
                Cv = p.Results.val_in;
            case 'Kv'
                Cv = p.Results.val_in * Kv_to_Cv;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        % GPM computation:
        GPM = Cv * sqrt(dP_psia/SG);
        % Return value assignment:
        y = GPM;
    case 'm3/h'
        switch p.Results.type_in
            case 'Cv'
                Kv = p.Results.val_in * Cv_to_Kv;
            case 'Kv'
                Kv = p.Results.val_in;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        % Q (m3/h) computation:
        Q_m3_h = Kv * sqrt(dP_bar/SG);
        % Return value assignment:
        y = Q_m3_h;
    otherwise
        error('ERROR. The function should not have gotten in here!') 
end

return
