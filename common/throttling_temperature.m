function Tout_C = throttling_temperature(Pin_bar, Tin_C, Pout_bar, refrigName)
% Computation of the output temperature of an isenthalpic throttling using
% the CoolProp library.

% Franco Ferrucci
% ferruccifranco@gmail.com
% Dec 2017

%% Constants
Tk = 273.15;
bar_to_Pa = 1e+5;

%% 
if Pin_bar < Pout_bar
    disp('Warning, output pressure is higher than input pressure.')
    disp('The output temperature will be computed anyways.')
end

%% 
Tin_K = Tin_C + Tk;
Pin_Pa = Pin_bar * bar_to_Pa;
Pout_Pa = Pout_bar * bar_to_Pa;

% Enthalpy:
h_in = CoolProp.PropsSI('Hmolar','P',Pin_Pa,'T',Tin_K,refrigName); % J/mol

% Output temperature, isenthalpic process:
Tout_K = CoolProp.PropsSI('T','Hmolar',h_in,'P',Pout_Pa,refrigName); % K
Tout_C = Tout_K - Tk;

