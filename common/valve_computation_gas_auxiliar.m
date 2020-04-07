function [y,isSupercriticalFlow] = valve_computation_gas_auxiliar(brand, type_in, val_in, Pin_bar, Pout_bar, Tin_C, Ggas)
% For use inside 'valve_computation_gas' function only!
% 
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% June 2018

%% Conversion 
cf = conversion_factors();
Pin_psi = Pin_bar * cf.bar_to_psi;
Pout_psi = Pout_bar * cf.bar_to_psi;
dP_psi = Pin_psi - Pout_psi;
Tin_R = cf.C_to_F(Tin_C)+460;

%% Determine sub-critical (non-choked) or super-critical (chocked) condition:
switch brand
    case 'Swagelok' % Swagelok (MS-06-84.pdf)
        N2 = 22.67;
        if Pout_psi > Pin_psi/2
            % Sub-critical:
            c = N2 * Pin_psi * (1-2/3*dP_psi/Pin_psi) * sqrt(dP_psi / (Pin_psi*Ggas*Tin_R));
            isSupercriticalFlow = false;
        else
            % Super-critical:
            c = 0.471 * N2 * Pin_psi * sqrt(1/(Ggas*Tin_R));
            isSupercriticalFlow = true;
            %disp('Super-critical flow!')
        end
    case 'Hoke' % HOKE (metering_valves_catalog_79013_10.12.pdf)
        if Pout_psi > Pin_psi/2
            % Sub-critical:
            c = 1360 * sqrt(dP_psi * Pin_psi / (Ggas * Tin_R));
            isSupercriticalFlow = false;
        else
            % Super-critical:
            c = NaN;
            error('Super-critical not found in HOKE catalog!')
        end
    otherwise
        error('''brand'' not found!');
end

%% Compute output:
switch type_in
    case 'SCFH'
        SCFH = val_in;
        SCFM = SCFH / 60;
        Cv = SCFM / c;
        y = Cv;
    case 'Cv'
        Cv = val_in;
        SCFM = Cv * c;
        SCFH = SCFM * 60;
        y = SCFH;
    otherwise
        error('''type_in'' not found!')
end
