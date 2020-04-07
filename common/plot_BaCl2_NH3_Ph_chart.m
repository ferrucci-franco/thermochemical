function h = plot_BaCl2_NH3_PT_chart(Pmin_NH3_bar, Pmin_BaCl2_bar, Pmax_BaCl2_bar)

% BARYUM CHLORURE/AMMONIA (BaCl2/NH3) COMPRESSOR-DRIVEN - P-h CHART
% Franco N. Ferrucci
% ferruccifranco@gmail.com
% Feb 2018

%% Parameters
bar2Pa = 1e5;
Pa2bar = 1e-5;
fluidName = 'Ammonia';

%% Change of reference to NBP: h=0, s=0 for saturated liquid at 1 atmosphere
CoolProp.set_reference_stateS(fluidName,'NBP');

%% P-h, BaCl2-NH3 equilibrium curve
N = 100;
P_BaCl2_bar = linspace(Pmin_BaCl2_bar,Pmax_BaCl2_bar,N);
P_BaCl2_Pa = bar2Pa * P_BaCl2_bar;
h_BaCl2 = zeros(1,N);
for i = 1:N
	T_BaCl2_K = clausius_clapeyron(P_BaCl2_bar(i),'bar','K','BaCl2-NH3'); % K
    h_BaCl2(i) = CoolProp.PropsSI('Hmolar','P',P_BaCl2_Pa(i),'T',T_BaCl2_K,fluidName); % J/mol
end

%% P-h, NH3-NH3 equilibrium curve
N = 100;
% Critical pressure:
Pcrit_bar = Pa2bar * CoolProp.Props1SI('Pcrit',fluidName);

P_NH3_bar = linspace(Pmin_NH3_bar,Pcrit_bar,N);
P_NH3_Pa = bar2Pa * P_NH3_bar;
h_NH3_liq = zeros(1,N);
h_NH3_vap = zeros(1,N);
for i = 1:N
    h_NH3_liq(i) = CoolProp.PropsSI('Hmolar','P',P_NH3_Pa(i),'Q',0,fluidName); % J/mol
    h_NH3_vap(i) = CoolProp.PropsSI('Hmolar','P',P_NH3_Pa(i),'Q',1,fluidName); % J/mol
end

%% Plot
% figure;
semilogy(h_NH3_liq,P_NH3_bar,'b','LineWidth',2)
hold on
semilogy(h_NH3_vap,P_NH3_bar,'r','LineWidth',2)
semilogy(h_BaCl2,P_BaCl2_bar,'k','LineWidth',2)
grid on

% Get current axes
h = gca;

return


   