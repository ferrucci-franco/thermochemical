function h = plot_BaCl2_NH3_PT_chart(Pmin_bar, Pmax_bar,temperature_units)

% BARYUM CHLORURE/AMMONIA (BaCl2/NH3) COMPRESSOR-DRIVEN - P-h CHART
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Feb 2018

%% Parameters
bar2Pa = 1e5;
Pa2bar = 1e-5;
fluidName = 'Ammonia';

%% Check if input arguments are above NH3 critical pressure:
Pcrit_bar = Pa2bar * CoolProp.Props1SI('Pcrit',fluidName);
if Pmin_bar > Pcrit_bar || Pmax_bar > Pcrit_bar
    disp(['ERROR. Input pressure above critical pressure (',num2str(Pcrit_bar),'bar)']);
    return
end

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS(fluidName,'NBP');

%% P-T, equilibrium curves
N = 100;
P_bar = linspace(Pmin_bar,Pmax_bar,N);
T_BaCl2_K = zeros(1,N);
T_NH3_K = zeros(1,N);
for i = 1:N
	T_BaCl2_K(i) = clausius_clapeyron(P_bar(i),'bar',temperature_units,'BaCl2-NH3'); % K
    T_NH3_K(i) = clausius_clapeyron(P_bar(i),'bar',temperature_units,'NH3-NH3'); % K
end

%% Plot
% figure;
semilogy(T_BaCl2_K,P_bar,'k','LineWidth',2)
hold on
semilogy(T_NH3_K,P_bar,'m','LineWidth',2)
grid on

% Get current axes
h = gca;

return


   