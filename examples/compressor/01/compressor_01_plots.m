%%
close all
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
delay = rpm_ref_01_time;
t = logsout{1}.Values.Time - delay;

my_xticks = 0:10:tEndSim;
my_xticks_min_str = (my_xticks);

% Array of figures
Hfig = [];

%%
hfig = figure;
Hfig = [Hfig hfig];
%
yyaxis left
plot(t,var{7},'LineWidth',lineWidth);
grid on;
ylabel_str = 'Motor speed (rpm)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
yyaxis right
plot(t,var{9},'LineWidth',lineWidth);
grid on;
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
ylabel_str = 'Mass flow rate (kg/h)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;

%%
hfig = figure;
Hfig = [Hfig hfig];
%
plot(t,var{11},'LineWidth',lineWidth);
grid on;
hold on;
plot(t,var{12},'LineWidth',lineWidth);
plot(t,var{14},'LineWidth',lineWidth);

hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
hfig.Children.FontSize = ticksFontSize;

ylabel_str = 'Power (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');

legend('\Deltah_i_r_r_e_v x dN_g_a_s/dt ',...
       'Mechanical power',...
       'Motor power',...
       'Location','southeast');
  
%%
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.7 0.8];
    Hfig(i).CurrentAxes.Position = [0.1 0.075 0.82 0.89];
    Hfig(i).CurrentAxes.XLabel.String = '(sec)';
    Hfig(i).CurrentAxes.XLabel.FontSize = labelFontSize;
    Hfig(i).CurrentAxes.XLabel.FontWeight = 'bold';
    Hfig(i).CurrentAxes.XLabel.Units = 'normalized';
    Hfig(i).CurrentAxes.XLabel.Position = [1.024 -0.02 0];
    Hfig(i).CurrentAxes.XLim = [t(1)/10 t(end)-1];
end

