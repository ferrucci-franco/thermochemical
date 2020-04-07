%%
% close all
clc

%%
labelFontSize = 20;
ticksFontSize = 20;
lineWidth = 4;
% feature('locale')

%%
% Variables' names:
var_name_list = {'Tamb (°C)',...            % 1
                 'T evap (°C)',...          % 2
                 'dT evap (°C)',...         % 3
                 'T cond (°C)',...          % 4
                 'P in (bar)',...           % 5
                 'P out (bar)',...          % 6
                 'w ref (rpm)',...          % 7
                 'w (rpm)',...              % 8
                 '(kg/h)',...               % 9
                 'T discharge (°C)',...     % 10
                 'P compr. irrev (W)',...   % 11
                 'T x w load (W)',...       % 12
                 'T x w motor (W)',...      % 13
                 'P elec: U x I (W)',...    % 14
                 'P available (W)',...      % 15
                 'U motor (V)',...          % 16
                 'I motor (A)',...          % 17
                 'Clamp',...                % 18
                 };

% Variables vectors:
clear var
for i = 1:length(var_name_list)
    var{i} = logsout.getElement(var_name_list{i}).Values.Data;
end

% Time vector:
delay = rpm_start_time;
t = logsout{1}.Values.Time - delay;

%%
hfig1 = figure(1);
%
idx = find(t > 0,1);
x = var{8}(idx:end)/rpm_nominal;
plot(x,var{9}(idx:end),'LineWidth',lineWidth);
grid on;
hold on;
ylim([5 21])
ylabel_str = 'Mass flow rate (kg/h)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig1.Children.FontSize = ticksFontSize;

%%
hfig2 = figure(2);
%
plot(x,var{14}(idx:end),'LineWidth',lineWidth);
ylabel_str = 'Electrical power (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
grid on;
hold on;
ylim([500 1150])
hfig2.Children.FontSize = ticksFontSize;

legend('T_e_v_a_p=5°C, T_c_o_n_d=30°C',...
       'T_e_v_a_p=-10°C, T_c_o_n_d=30°C',...
       'Location','northwest');
   
%%
Hfig = [hfig1 hfig2];
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.7 0.8];
    Hfig(i).CurrentAxes.Position = [0.1 0.1 0.8 0.87];
    Hfig(i).CurrentAxes.XLabel.String = '\omega/\omega_n_o_m';
    Hfig(i).CurrentAxes.XLabel.FontSize = labelFontSize;
    Hfig(i).CurrentAxes.XLabel.FontWeight = 'bold';
    Hfig(i).CurrentAxes.XLabel.Units = 'normalized';
    Hfig(i).CurrentAxes.XLabel.Position = [1.065 0 0];
    Hfig(i).CurrentAxes.XLim = [0.6 1];
end

