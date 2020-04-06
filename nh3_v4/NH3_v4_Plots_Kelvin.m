%% PLOT OF THERMODYNAMICAL PROPERTIES OF NH3 USING CoolProp
%
% Version 4
%
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Sept 2018

%% Cleanup
close all
clear
% clc

%% Parameters
% Resample factor:
N = 20;

% Choose which set of plot to print:
plot_saturation =           0; % 1 for YES, 0 for NO
plot_TP_2D =                0; % 1 for YES, 0 for NO
plot_TP_indep_variable =    0; % 1 for YES, 0 for NO
plot_sP_indep_variable =    0; % 1 for YES, 0 for NO
plot_hP_indep_variable =    0; % 1 for YES, 0 for NO
plot_Trho_indep_variable =  1; % 1 for YES, 0 for NO

% Constants
Tk = 273.15;

%% Load nh3_v4 structure
load nh3_v4;

%% Saturation properties
if plot_saturation == 1
    % Saturation curve:
    figure
    plot(nh3_v4.sat.T,nh3_v4.sat.Psat)
    xlabel('Temperature (K)')
    ylabel('Saturation Pressure (bar)')

    % Molar density:
    figure
    plot(nh3_v4.sat.T,nh3_v4.sat.liq.rho_molar,'b'), hold on
    plot(nh3_v4.sat.T,nh3_v4.sat.vap.rho_molar,'r'), grid on
    xlabel('Temperature (K)')
    ylabel('Molar density (mol/m3)')

    % Specific volume:
    figure
    plot(nh3_v4.sat.T,1./nh3_v4.sat.liq.rho_molar,'b'), hold on
    plot(nh3_v4.sat.T,1./nh3_v4.sat.vap.rho_molar,'r'), grid on
    xlabel('Temperature (K)')
    ylabel('Specific volume (m3/mol)')
    
    % Specific volume, logarithmic:
    figure
    semilogy(nh3_v4.sat.T,1./nh3_v4.sat.liq.rho_molar,'b'), hold on
    semilogy(nh3_v4.sat.T,1./nh3_v4.sat.vap.rho_molar,'r'), grid on
    xlabel('Temperature (K)')
    ylabel('Specific volume (m3/mol)')
    
    % Inernal energy:
    figure
    plot(nh3_v4.sat.T,nh3_v4.sat.liq.u_molar,'b'), hold on
    plot(nh3_v4.sat.T,nh3_v4.sat.vap.u_molar,'r'), grid on
    xlabel('Temperature (K)')
    ylabel('Internal energy (J/mol)')
    
    % Complete with the rest of plots!
    
end

%% (T,P) INDEPENDENT VARIABLES, 2D PLOTS
if plot_TP_2D == 1
    % Saturation curve:
    figure
    plot(nh3_v4.sat.T,nh3_v4.sat.Psat)
    xlabel('Temperature (K)')
    ylabel('Saturation Pressure (bar)')

    % P(h):
    figure
    semilogy(nh3_v4.sat.liq.h_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    hold on
    semilogy(nh3_v4.sat.vap.h_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    semilogy(nh3_v4.no_sat.T_P_indep.var_dep.h_molar(1:N:end, 1:N:end)',... 
         nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end))
    xlabel('Enthalpy (J/mol)')
    ylabel('Pressure (bar)')

    % P(u):
    figure
    plot(nh3_v4.sat.liq.u_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    hold on
    plot(nh3_v4.sat.vap.u_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    plot(nh3_v4.no_sat.T_P_indep.var_dep.u_molar(1:N:end, 1:N:end)',...
         nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end))
    xlabel('Internal Energy (J/mol)')
    ylabel('Pressure (bar)')

    % P(s):
    figure
    plot(nh3_v4.sat.liq.s_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    hold on
    plot(nh3_v4.sat.vap.s_molar, nh3_v4.sat.Psat,'k','LineWidth',3)
    plot(nh3_v4.no_sat.T_P_indep.var_dep.s_molar(1:N:end, 1:N:end)',...
         nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end))
    xlabel('Entropy (J/mol/K)')
    ylabel('Pressure (bar)')
end
%% (T,P) INDEPENDENT VARIABLES, 3D PLOTS
if plot_TP_indep_variable == 1
    % Phase(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.phase(1:N:end, 1:N:end))
    title('Ammonia phase, phase(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Phase')

    % rho(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.rho_molar(1:N:end, 1:N:end))
    title('Ammonia Density, rho(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Density (mol/m3)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.rho_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.rho_molar,'r','LineWidth',3)

    % 1/rho(P,T) (molar specific volume):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         1./nh3_v4.no_sat.T_P_indep.var_dep.rho_molar(1:N:end, 1:N:end))
    title('Ammonia specific volume, v(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Molar specific volume (m3/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          1./nh3_v4.sat.liq.rho_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          1./nh3_v4.sat.vap.rho_molar,'r','LineWidth',3)
    set(gca,'ZScale','log')

    % beta(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.beta(1:N:end, 1:N:end))
    title('Ammonia volumetric expansion coefficient, \beta(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: \beta (1/K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.beta,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.beta,'r','LineWidth',3)
    
    % kappa(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.kappa(1:N:end, 1:N:end))
    title('Ammonia isothermal compressibility factor, \kappa(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: \kappa (1/Pa)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.kappa,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.kappa,'r','LineWidth',3)
    
    % h(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.h_molar(1:N:end, 1:N:end))
    title('Ammonia Enthalpy, h(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Enthalpy (J/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.h_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.h_molar,'r','LineWidth',3)

    % s(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.s_molar(1:N:end, 1:N:end))
    title('Ammonia Entropy, s(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Entropy (J/mol/K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.s_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.s_molar,'r','LineWidth',3)

    % u(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.u_molar(1:N:end, 1:N:end))
    title('Ammonia Internal Energy, u(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Internal Energy (J/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.u_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.u_molar,'r','LineWidth',3)

    % Cp(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.Cp_molar(1:N:end, 1:N:end))
    title('Ammonia Cp, Cp(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Cp (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.Cp_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.Cp_molar,'r','LineWidth',3)

    % Cv(P,T):
    figure
    mesh(nh3_v4.no_sat.T_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_P_indep.var_dep.Cv_molar(1:N:end, 1:N:end))
    title('Ammonia Cv, Cv(P,T)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Cv (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.Cv_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.Cv_molar,'r','LineWidth',3)
end
%% (s,P) INDEPENDENT VARIABLES, 3D PLOTS
if plot_sP_indep_variable == 1
    % Phase(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.phase(1:N:end, 1:N:end))
    title('Ammonia phase, phase(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Phase')

    % T(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.T(1:N:end, 1:N:end))
    title('Ammonia Temperature, T(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Temperature (K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.T,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,....
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.T,'r','LineWidth',3)

    % rho(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.rho_molar(1:N:end, 1:N:end))
    title('Ammonia Density, rho(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Density (mol/m3)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.rho_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.rho_molar,'r','LineWidth',3)

    % beta(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.beta(1:N:end, 1:N:end))
    title('Ammonia volumetric expansion coefficient, \beta(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: \beta (1/K)')         
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.beta,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.beta,'r','LineWidth',3)
    
    % kappa(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.kappa(1:N:end, 1:N:end))
    title('Ammonia isothermal compressibility factor, \kappa(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: \kappa (1/Pa)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.kappa,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.kappa,'r','LineWidth',3)    

    % h(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.h_molar(1:N:end, 1:N:end))
    title('Ammonia Enthalpy, h(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Enthalpy (J/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.h_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.h_molar,'r','LineWidth',3)

    % u(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.u_molar(1:N:end, 1:N:end))
    title('Ammonia Internal Energy, u(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Internal Energy (J/mol)')
    hold on
    plot3(nh3_v4.sat.Psat, nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.u_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat, nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.u_molar,'r','LineWidth',3)

    % Cp(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.Cp_molar(1:N:end, 1:N:end))
    title('Ammonia Cp, Cp(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Cp (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.Cp_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.Cp_molar,'r','LineWidth',3)

    % Cv(P,s):
    figure
    mesh(nh3_v4.no_sat.s_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_indep.s_molar(1:N:end),...
         nh3_v4.no_sat.s_P_indep.var_dep.Cv_molar(1:N:end, 1:N:end))
    title('Ammonia Cv, Cv(P,s)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Entropy (J/mol/K)')
    zlabel('Z: Cv (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.s_molar,...
          nh3_v4.sat.liq.Cv_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.s_molar,...
          nh3_v4.sat.vap.Cv_molar,'r','LineWidth',3)
end
%% (h,P) INDEPENDENT VARIABLES, 3D PLOTS
if plot_hP_indep_variable == 1
    % Phase(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.phase(1:N:end, 1:N:end))
    title('Ammonia phase, phase(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Phase')

    % T(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.T(1:N:end, 1:N:end))
    title('Ammonia Temperature, T(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Temperature (K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.T,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.T,'r','LineWidth',3)

    % rho(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.rho_molar(1:N:end, 1:N:end))
    title('Ammonia Density, rho(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Density (mol/m3)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.rho_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.rho_molar,'r','LineWidth',3)

    % beta(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.beta(1:N:end, 1:N:end))
    title('Ammonia volumetric expansion coefficient, \beta(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: \beta (1/K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.beta,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.beta,'r','LineWidth',3)      
      
    % kappa(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.kappa(1:N:end, 1:N:end))
    title('Ammonia isothermal compressibility factor, \kappa(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: \kappa (1/Pa)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.kappa,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.kappa,'r','LineWidth',3)   
      
    % s(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.s_molar(1:N:end, 1:N:end))
    title('Ammonia Enthalpy, s(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Entropy (J/mol/K)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.s_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.s_molar,'r','LineWidth',3)

    % u(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.u_molar(1:N:end, 1:N:end))
    title('Ammonia Internal Energy, u(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Internal Energy (J/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.u_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.u_molar,'r','LineWidth',3)

    % Cp(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.Cp_molar(1:N:end, 1:N:end))
    title('Ammonia Cp, Cp(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Cp (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.Cp_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.Cp_molar,'r','LineWidth',3)

    % Cv(P,h):
    figure
    mesh(nh3_v4.no_sat.h_P_indep.var_indep.P(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_indep.h_molar(1:N:end),...
         nh3_v4.no_sat.h_P_indep.var_dep.Cv_molar(1:N:end, 1:N:end))
    title('Ammonia Cv, Cv(P,h)')
    xlabel('X: Pressure (bar)')
    ylabel('Y: Enthalpy (J/mol)')
    zlabel('Z: Cv (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.liq.h_molar,...
          nh3_v4.sat.liq.Cv_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.Psat,...
          nh3_v4.sat.vap.h_molar,...
          nh3_v4.sat.vap.Cv_molar,'r','LineWidth',3)
end

%% (T,rho) INDEPENDENT VARIABLES, 3D PLOTS
if plot_Trho_indep_variable == 1
    % Phase(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.phase(1:N:end, 1:N:end))
    title('Ammonia phase, phase(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Phase')

    % P(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.P(1:N:end, 1:N:end))
    title('Ammonia pressure, P(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('P: Pressure (bar)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.Psat,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.Psat,'r','LineWidth',3)

    % beta(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.beta(1:N:end, 1:N:end))
    title('Ammonia volumetric expansion coefficient, \beta(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: \beta (1/K)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.beta,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.beta,'r','LineWidth',3)
      
    % kappa(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.kappa(1:N:end, 1:N:end))
	title('Ammonia isothermal compressibility factor, \kappa(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: \kappa (1/Pa)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.kappa,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.kappa,'r','LineWidth',3)      
      
    % h(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.h_molar(1:N:end, 1:N:end))
    title('Ammonia Enthalpy, h(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Enthalpy (J/mol)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.h_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.h_molar,'r','LineWidth',3)

    % s(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.s_molar(1:N:end, 1:N:end))
    title('Ammonia Entropy, s(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Entropy (J/mol/K)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.s_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.s_molar,'r','LineWidth',3)

    % u(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.u_molar(1:N:end, 1:N:end))
    title('Ammonia Internal Energy, u(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Internal Energy (J/mol)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.u_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.u_molar,'r','LineWidth',3)

    % Cp(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.Cp_molar(1:N:end, 1:N:end))
    title('Ammonia Cp, Cp(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Cp (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.Cp_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.Cp_molar,'r','LineWidth',3)

    % Cv(rho,T):
    figure
    mesh(nh3_v4.no_sat.T_rho_indep.var_indep.rho_molar(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_indep.T(1:N:end),...
         nh3_v4.no_sat.T_rho_indep.var_dep.Cv_molar(1:N:end, 1:N:end))
    title('Ammonia Cv, Cv(rho,T)')
    xlabel('X: Density (mol/m3)')
    ylabel('Y: Temperature (K)')
    zlabel('Z: Cv (J/K/mol)')
    hold on
    plot3(nh3_v4.sat.liq.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.liq.Cv_molar,'b','LineWidth',3)
    plot3(nh3_v4.sat.vap.rho_molar,...
          nh3_v4.sat.T,...
          nh3_v4.sat.vap.Cv_molar,'r','LineWidth',3)
end