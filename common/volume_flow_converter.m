function flow_out = volume_flow_converter(flow_in, unit_in, unit_out)

% volume_flow_converter    Volume flow unit converter
% Use:
%    flow_out = volume_flow_converter(flow_in, unit_in, unit_out)
% 
% The possible units (either for intput or output flow) are: 
%    'L/sec'
%    'L/min'
%    'L/h'
%    'm3/sec'
%    'm3/min'
%    'm3/h'
%    'cfm' (cubit feet per minute)
% 
% Exmaples:
%    flow_out = volume_flow_converter(1.2, 'L/min', 'cfm')
%    flow_out = volume_flow_converter(0.7, 'm3/h', 'L/min')
% 
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% March 2017

%% Input parser
% Parser object creation:
p = inputParser;

% 1st input:
addRequired(p,'flow_in',@(x) isnumeric(x) && x > 0);

% 2nd and 3rd inputs:
expectedUnits = {'L/sec','L/min','L/h','m3/sec','m3/min','m3/h','cfm'};
addRequired(p,'unit_in',@(x) any(validatestring(x,expectedUnits)));
addRequired(p,'unit_out',@(x) any(validatestring(x,expectedUnits)));

% Run the parsing to check inputs:
parse(p, flow_in, unit_in, unit_out);

%% Unit identification 
% Flow in units:
switch unit_in
    case 'L/sec'
        idx_row = 1;
    case 'L/min'
        idx_row = 2;
    case 'L/h'
        idx_row = 3;
    case 'm3/sec'
        idx_row = 4;
    case 'm3/min'
        idx_row = 5;
    case 'm3/h'
        idx_row = 6;
    case 'cfm'
        idx_row = 7;
    otherwise
        error('ERROR. The function should not have gotten in here!')
end
% Flow out units:
switch unit_out
    case 'L/sec'
        idx_col = 1;
    case 'L/min'
        idx_col = 2;
    case 'L/h'
        idx_col = 3;
    case 'm3/sec'
        idx_col = 4;
    case 'm3/min'
        idx_col = 5;
    case 'm3/h'
        idx_col = 6;
    case 'cfm'
        idx_col = 7;
	otherwise
        error('ERROR. The function should not have gotten in here!')
end

%% 'Foot' (ft) conversion
% Load conversion factor variable:
c = conversion_factors();

% Foot to meter:
ft_to_m = c.ft_to_m; % [m/foot]

% Conversion constants from 'cfm':
cfm_to_m3m = ft_to_m^3 / 1;     % to m3/min
cfm_to_m3s = cfm_to_m3m / 60;   % to m3/sec
cfm_to_m3h = cfm_to_m3m * 60;   % to m3/h
cfm_to_Lm = cfm_to_m3m * 1e3;   % to L/min
cfm_to_Ls = cfm_to_Lm / 60;     % to L/sec
cfm_to_Lh = cfm_to_Lm * 60;     % to L/h

%% Conversion matrix
K = [   1,        60,      3600,       1e-3,    1e-3*60,  1e-3*3600,  1/cfm_to_Ls; ...
     1/60,         1,        60,    1e-3/60,       1e-3,    1e-3*60,  1/cfm_to_Lm; ...
   1/3600       1/60,         1,  1e-3/3600,    1e-3/60,       1e-3,  1/cfm_to_Lh; ...
      1e3,    1e3*60,  1e3*3600,          1,         60,       3600, 1/cfm_to_m3s; ...
   1e3/60,       1e3,    1e3*60,       1/60,          1,         60, 1/cfm_to_m3m; ...
 1e3/3600,    1e3/60,       1e3,     1/3600,       1/60,          1, 1/cfm_to_m3h;...
cfm_to_Ls, cfm_to_Lm, cfm_to_Lh, cfm_to_m3s, cfm_to_m3m, cfm_to_m3h,            1];
    
%% Conversion
flow_out = flow_in * K(idx_row,idx_col);
return

