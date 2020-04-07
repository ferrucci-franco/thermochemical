function Tdischarge_C = Tdischarge_computation(Pintake_bar, Tintake_C, Pdischarge_bar, eta_is, refrigName)

%%
Tkelvin = 273.15;
bar_to_Pa = 1e+5;           % Pa/bar

%%
Tintake_K = Tintake_C + Tkelvin;
%
Pintake_Pa = Pintake_bar * bar_to_Pa;
Pdischarge_Pa = Pdischarge_bar * bar_to_Pa;
%
% Intake enthalpy and entropy:
h_intake = CoolProp.PropsSI('Hmolar','T',Tintake_K,'P',Pintake_Pa,refrigName); % J/mol
s_intake = CoolProp.PropsSI('Smolar','T',Tintake_K,'P',Pintake_Pa,refrigName); % J/K/mol

% Discharge enthalpy, isentropic process:
h_discharge_ise = CoolProp.PropsSI('Hmolar','Smolar',s_intake,'P',Pdischarge_Pa,refrigName); % J/mol

dh_real = (h_discharge_ise - h_intake) / eta_is;
h_discharge_real = dh_real + h_intake;

Tdischarge_K = CoolProp.PropsSI('T','Hmolar',h_discharge_real,'P',Pdischarge_Pa,refrigName); % J/mol
Tdischarge_C = Tdischarge_K - Tkelvin;
