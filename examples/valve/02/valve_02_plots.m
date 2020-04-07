%% Cleanup
close all
clc

%%
labelFontSize = 20;
ticksFontSize = 20;
lineWidth = 4;
% feature('locale')

%%
% Variables' names:
var_name_list = {'P upstream (bar)',...         % 1
                 'P downstream (bar)',...       % 2
                 'W (kg/h)',...                 % 3
                 'Regime',...                   % 4
                 'Cv',...                       % 5
                 };

% Variables vectors:
clear var
for i = 1:length(var_name_list)
    var{i} = logsout.getElement(var_name_list{i}).Values.Data;
end

% Time vector:
t = logsout{1}.Values.Time;

% Array of figures
Hfig = [];

%%
hfig = figure;
Hfig = [Hfig hfig];
x = var{2}./var{1};
yyaxis left
plot(x,var{3},'LineWidth',lineWidth);
grid on;
%
xlabel_str = 'P_D_O_W_N_S_T_R_E_A_M / P_U_P_S_T_R_E_A_M';
xlabel(xlabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
ylabel_str = 'Mass flow rate (kg/h)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
yyaxis right
plot(x,var{4},'LineWidth',lineWidth);
ylabel_str = 'Valve regime';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
ylim([-1.2 1.2])
%
hfig.Children.YTick = [-1 1];
hfig.Children.YTickLabel = {'Chocked', 'Non-choked'};
hfig.Children.FontSize = ticksFontSize;

%%
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.7 0.8];
end

