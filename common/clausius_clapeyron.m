function y = clausius_clapeyron(Teq_or_Peq, unit_in, unit_out, pair)
% CLAUSIUS_CLAPEYRON Computes the Clausius-Clapeyron equilibrium condition
% for the selected pair.
% 
% Use:
%    y = clausius_clapeyron(pair, Teq_or_Peq, unit_in, unit_out)
%
% The allowed pairs are:
%    'NH3-NH3'
%    'BaCl2-NH3'
%    'Mn62-NH3'
% 
% The possible units (either for intput or output flow) are: 
%    'bar'
%    'Pa'
%    'K'
%    'Celsius'
% 
% Exmaples:
%    Peq = clausius_clapeyron(40, 'Celsius', 'bar', 'BaCl2-NH3')
%    Teq = clausius_clapeyron(15, 'bar', 'Celsius', 'NH3-NH3')
% 
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% May 2017

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
addRequired(p,'Teq_or_Peq',@(x) isnumeric(x));

% 2nd and 3rd inputs:
expectedUnits = {'bar','Pa','K','Celsius'};
addRequired(p,'unit_in',@(x) any(validatestring(x,expectedUnits)));
addRequired(p,'unit_out',@(x) any(validatestring(x,expectedUnits)));

% 4th input:
expectedUnits = {'NH3-NH3','BaCl2-NH3','Mn62-NH3'};
addRequired(p,'pair',@(x) any(validatestring(x,expectedUnits)));

% Run the parsing to check inputs:
parse(p, Teq_or_Peq, unit_in, unit_out, pair);

%% Unit conversion and constants
bar_to_Pa = 1e5;
Pa_to_bar = 1e-5;
Tk = 273.15;
R = 8.314472; % [J/K/mol]
err_msg = 'The input and output units cannot reffer to the same magniture';

%% Pair identification
switch pair
    case 'NH3-NH3'
        data = get_material_properties('Ammonia gas (NH3)');
        dh = data.dh;           % [J/mol]
        ds = data.ds;           % [J/mol/K]
        Pref = data.Pref_bar;   % [bara]
    case 'BaCl2-NH3'
        data = get_material_properties('Barium chloride/Ammonia (BaCl2/NH3)');
        dh = data.dh_r;     % [J/mol]
        ds = data.ds_r;     % [J/mol/K]
        Pref = data.Pref_r; % [bara]
    case 'Mn62-NH3'
        data = get_material_properties('Mn62-NH3');
        dh = data.dh_r;     % [J/mol]
        ds = data.ds_r;     % [J/mol/K]
        Pref = data.Pref_r; % [bara]
    otherwise
        error('ERROR. The function should not have gotten in here!')
end

%% In unit
switch unit_in
    case 'bar'
        in = 'P';
        Peq = Teq_or_Peq;
    case 'Pa'
        in = 'P';
        Peq = Teq_or_Peq * Pa_to_bar;
    case 'K'
        in = 'T';
        Teq = Teq_or_Peq;
    case 'Celsius'
        in = 'T';
        Teq = Teq_or_Peq + Tk;
    otherwise
        error('ERROR. The function should not have gotten in here!')
end

%% Clausius-Clapeyron
if in == 'P'
    Tsat = dh ./ (ds - R * log(Peq/Pref));
else
    Psat = Pref * exp(-dh/R./Teq+ds/R);
end

%% Out unit
switch unit_out
    case 'bar'
        if in == 'P'
            error(err_msg);
        else
            y = Psat;
        end
    case 'Pa'
        if in == 'P'
            error(err_msg);
        else
            y = Psat * bar_to_Pa;
        end
    case 'K'
        if in == 'T'
            error(err_msg);
        else
            y = Tsat;
        end
    case 'Celsius'
        if in == 'T'
            error(err_msg);
        else
            y = Tsat - Tk;
        end
    otherwise
        error('ERROR. The function should not have gotten in here!')
end
