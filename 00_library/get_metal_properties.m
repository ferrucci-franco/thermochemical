function data = get_metal_properties(material, varargin)

%%
% GET_METAL_PROPERTIES returns a structure containing properties of the
% metal given as a string input.
%
% The input argument 'varargin' is there for future improvements of the
% function.
%
%
% Data obtained from:
%   https://www.engineeringtoolbox.com/metal-alloys-densities-d_50.html
%   https://www.engineeringtoolbox.com/specific-heat-solids-d_154.html
%   https://www.engineersedge.com/materials/specific_heat_capacity_of_metals_13259.htm

% Franco Ferrucci
% ferruccifranco@gmail.com
% Jan 2018

%%

switch material
    case 'Aluminium'
        cp = 870;   % J/K/kg, at 0°C
        rho = 2700; % kg/m3, 6061 aluminium alloy
    case 'Steel'
        cp = 490; 
        rho = 7850;
    case 'Stainless steel'
        cp = 500;
        rho = 7700; 
    case 'Copper'
        cp = 390;
        rho = 8940;
    otherwise 
        error('Material not defined');
end

data.cp = cp;
data.rho = rho;

return
    