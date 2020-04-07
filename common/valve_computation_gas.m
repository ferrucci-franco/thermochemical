function y = valve_computation_gas(type_out, val_in, type_in, Pin_bar, Pout_bar, Tin_C, fluidName)
% valve_computation_gas    Valve parameter computation (with no condensing)
% 
% Use:
%     y = valve_computation_gas(type_out, val_in, type_in, Pin_bar, Pout_bar, Tin_C, fluidName)
% with:
%    - type_out  : type or units of desired output
%    - val_in    : input value
%    - type_in   : type or units of input
%    - Pin_bar   : pressure (bara) at the valve inlet
%    - Pout_bar  : pressure (bara) at the valve outlet
%    - Tin_C     : temperature (°C) at the valve inlet
%    - fluidName : name of fluid
%
% The possible choices for 'type_in' are:
%    'Cv' (Cv uses US SCFH and psia)
%    'Kv' (Kv uses m3/h and bara)
%    'SCFH' (at 60°F,1atm)
%    'std m3/h' (at 60°F,1atm)
%    'mol/sec'
%
% The possible choices for 'type_out' are:
%    'Cv' (Cv uses US SCFH and psia)
%    'Kv' (Kv uses m3/h and bara)
%    'SCFH' (at 60°F,1atm)
%    'std m3/h' (at 60°F,1atm)
%
% Note that some combinations of 'type_in' and 'type_out' are not implemented.
% 
% To get a list of accepted fluids, please run the following funtion:
%     CoolProp.get_global_param_string('FluidsList')
% 
% NOTE: the Cv computation uses an old definition of 'standard' temperature
%       and pressure, as it uses 60°F and 1atm and calls it 'standard'. The
%       ANSI/ISA-75.01.01 (IEC 60534-2-1 Mod) Standard gives more detail 
%       about it.
%
% Examples of use:
%       Cv   = valve_computation_gas('Cv',100*60,'SCFH',70,30,20,'Air')
%       flow = valve_computation_gas('SCFH',0.2120,'Cv',70,30,20,'Air')
%       Cv   = valve_computation_gas('Kv',15,'std m3/h',15,4,150,'Ammonia')
%       flow = valve_computation_gas('std m3/h',0.07,'Kv',15,4,150,'Ammonia')
% 
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% June 2018

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
expectedValues = {'Kv','Cv','SCFH','std m3/h'};
addRequired(p,'type_out',@(x) any(validatestring(x,expectedValues)));

% 2nd input:
addRequired(p,'val_in',@(x) isnumeric(x) && x > 0);

% 3rd input:
expectedValues = {'Kv','Cv','SCFH','std m3/h','mol/sec'};
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

%% Constants and conversion factors
c = conversion_factors();

% Reference temperature (°K) and pressure (bar) used for Cv compoutation:
% NOTE: the Cv computation uses an old definition of 'standard' temperature
%       and pressure, as it uses 60°F and 1atm and calls it 'standard'. The
%       ANSI/ISA-75.01.01 (IEC 60534-2-1) Standard gives more detail 
%       about it.
Tref_K = c.F_to_K(60);
Pref_Pa = 1 * c.atm_to_Pa;
%
Tref_C = c.K_to_C(Tref_K);
Pref_bar = Pref_Pa * c.Pa_to_bar;

% Air density computation (kg/m3) at 'standard' conditions:
rho_air_ref_kg_m3 = CoolProp.PropsSI('DMASS','P',Pref_Pa,'T',Tref_K,'Air');

valve_brand = 'Swagelok';
% valve_brand = 'Hoke';

%% Fluid Pressure and Temperature
% Read input parameters:
Pin_bar = p.Results.Pin_bar;
Pout_bar = p.Results.Pout_bar;
Tin_C = p.Results.Tin_C;

% Fluid density computation (kg/m3) at 'standard' conditions:
rho_ref_kg_m3 = CoolProp.PropsSI('DMASS','P',Pref_Pa,'T',Tref_K,fluidName);

% Specific gravity S.G. (referred to air):
SG = rho_ref_kg_m3/rho_air_ref_kg_m3;

%% Check if fluid inlet is in gas state
% Inlet phase:
phase_in = CoolProp.PhaseSI('P', Pin_bar * c.bar_to_Pa, 'T', Tin_C + c.Tk, fluidName);

% Check:
s1 = {'supercritical','gas','supercritical_gas'};
if all(~strcmp(phase_in,s1))
    isNotLiquidAtInlet = false;
    warning('Fluid is not gas at valve inlet. Result might be wrong.')
else
    isNotLiquidAtInlet = true;
end

%% Check if there is no condensing phenomenom (isenthalpic pressure drop):
% Outlet temperature (assuming isenthalpic pressure drop):
Tout_C = throttling_temperature(Pin_bar, Tin_C, Pout_bar, fluidName);

% Check if point (Touc_C,Pout_bar) is inside two-phase dome:
Pcrit_bar = CoolProp.Props1SI('Pcrit',fluidName) * c.Pa_to_bar;
if Pout_bar < Pcrit_bar && isNotLiquidAtInlet
    Tsat_C = CoolProp.PropsSI('T','P',Pout_bar*c.bar_to_Pa,'Q',1,fluidName) - c.Tk;
    if abs(Tout_C-Tsat_C) < 1
        warning('Condensing occurring! Result might be wrong.')
    end
end

%% Output computation
switch p.Results.type_out
    case {'Cv', 'Kv'}
        switch p.Results.type_in
            case 'SCFH'
                SCFH = p.Results.val_in;
            case 'std m3/h'
                SCFH = p.Results.val_in * c.m3_h_to_CFH;
            case 'mol/sec'
                std_m3_h = mass_to_volume_flow_converter(p.Results.val_in,'mol/sec','m3/h',[Tref_C,Pref_bar],fluidName);
                SCFH = std_m3_h * c.m3_h_to_CFH;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        
        % Cv computation:
        Cv = valve_computation_gas_auxiliar(valve_brand, 'SCFH', SCFH, Pin_bar, Pout_bar, Tin_C, SG);
        
        % Return value assignment:
        if strcmp(p.Results.type_out,'Cv')
            y = Cv;
        else
            Kv = Cv * c.Cv_to_Kv;
            y = Kv;
        end

    case {'SCFH','std m3/h'}
        switch p.Results.type_in
            case 'Cv'
                Cv = p.Results.val_in;                
            case 'Kv'
                Cv = p.Results.val_in * c.Kv_to_Cv;
            otherwise
                error('ERROR. Bad combination of ''type_in'' and ''type_out''')
        end
        % SCFH computation:
        SCFH = valve_computation_gas_auxiliar(valve_brand, 'Cv', Cv, Pin_bar, Pout_bar, Tin_C, SG);
        
        % Return value assignment:
        if strcmp(p.Results.type_out,'SCFH')
            y = SCFH;
        else
            % Q (std m3/h) computation:
            Q_std_m3_h = SCFH * c.CFH_to_m3_h;
            y = Q_std_m3_h;
        end
        
    otherwise
        error('ERROR. The function should not have gotten in here!') 
end

return
