function data = get_material_properties(material, varargin)

%%
% GET_MATERIAL_PROPERTIES returns a structure containing properties of the
% metal given as a string input.
%
% The input argument 'varargin' is there for future improvements of the
% function.
%
%
% Ref:
%  [1] EES Software
%  [2] https://webbook.nist.gov/cgi/cbook.cgi?ID=C7782425&Mask=2

% Franco Ferrucci
% ferruccifranco@gmail.com
% March 2018

%%
switch material
    case 'Aluminum 1100'
        data.cp = 905.9;    % J/K/kg, EES: Cp(Aluminum_1100, T=30)
        data.rho = 2658;    % kg/m3, EES: Density(Aluminum_1100, T=30)
        data.k = 211.8;     % W/m/K, EES: Conductivity(Aluminum_1100, T=30)       
    case 'Steel'
        data.cp = 464.5;    % J/K/kg, EES: Cp(Carbon_steel, T=30)
        data.rho = 7847;    % kg/m3, EES: Density(Carbon_steel, T=30)
        data.k = 64.65;     % W/m/K, EES: Conductivity(Carbon_steel, T=25)
    case 'Stainless steel AISI316'
        data.cp = 490.8;    % J/K/kg, EES: Cp(Stainless_AISI316, T=30)
        data.rho = 8023;    % kg/m3, EES: Density(Stainless_AISI316, T=30)
        data.k = 13.5;      % W/m/K, EES: Conductivity(Stainless_AISI310, T=30)
    case 'Copper'
        data.cp = 389;      % J/K/kg, EES: Cp(Copper, T=30)
        data.rho = 8956;    % kg/m3, EES: Density(Copper, T=30)
        data.k = 396.1;     % W/m/K, EES: Conductivity(Copper, T=30)
    case 'Barium chloride/Ammonia (BaCl2/NH3)'
        data.dh_r = 38250;          % J/mol of gas
        data.ds_r = 232.38;         % J/K/mol of gas
        data.Pref_r = 1e-5;         % bar
        data.cp_salt = 75.1;        % J/K/mol
        data.cp_gas = 42.5775;      % J/K/mol
        data.M_salt = 0.20823;      % kg/mol
        data.M_gas = 0.01703026;    % kg/mol
        data.nu = 8;                % mol NH3/mol BaCl2
    case 'ENG'
        data.M = 0.0120107;             % kg/mol
        data.cp = 714.36;               % J/K/kg  [2]
        data.cp_molar = data.cp*data.M; % J/K/mol
    case 'Ammonia gas (NH3)'
        data.dh = 23366;        % J/mol
        data.ds = 193.3;        % J/K/mol
        data.Pref_bar = 1e-5;   % bar
        data.cp = 42.5775;      % J/K/mol
        data.M = 0.01703026;    % kg/mol
    case 'Mn62-NH3'
        data.dh_r = 47416;      % J/mol
        data.ds_r = 227.9;      % J/K/mol
        data.Pref_r = 1e-5;     % bar
    otherwise 
        error('Material not defined');
end

return

%% EES commands
% T = 30 [C]
% 
% Cp_Al=Cp(Aluminum_1100, T=T)
% rho_Al=Density(Aluminum_1100, T=T)
% k_Al=Conductivity(Aluminum_1100, T=T)
% M_Al=MolarMass(Aluminum_1100)
% 
% Cp_Steel=Cp(Carbon_steel, T=T)
% rho_Steel=Density(Carbon_steel, T=T)
% k_Steel=Conductivity(Carbon_steel, T=T)
% 
% Cp_Copper=Cp(Copper, T=T)
% rho_Copper=Density(Copper, T=T)
% k_Copper=Conductivity(Copper, T=T)
% M_Copper=MolarMass(Copper)
% 
% Cp_Stainless=Cp(Stainless_AISI316, T=T)
% rho_Stainless=Density(Stainless_AISI316, T=T)
% k_Stainless=Conductivity(Stainless_AISI316, T=T)
    