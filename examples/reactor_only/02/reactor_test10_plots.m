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
var_name_list = {'Q prod (W)',...                   % 1
                 'Q heater to reactor (W)',...      % 2
                 'Q heater to exterior (W)',...     % 3
                 'Q wall to composite (W)',...      % 4
                 'T heater (°C)',...                % 5
                 'Tw (°C)',...                      % 6
                 'Tr (°C)',...                      % 7
                 'Pr',...                           % 8
                 'X',...                            % 9
                 'N_gas_free_volume (mol)',...      % 10
                 'N_gas_absorved',...               % 11
                 'N_gas_reactor (mol)',...          % 12
                 'dn/dt (mol/sec)',...              % 13
                 'phase'};                          % 14
             
% Variables vectors:
clear var
for i = 1:length(var_name_list)
    var{i} = logsout.getElement(var_name_list{i}).Values.Data;
end

% Time vector:
time_bias = tStart_Q;
t = logsout{1}.Values.Time - time_bias;

% Array of figures
Hfig = [];

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{1},'LineWidth',lineWidth);
grid on;
hold on
plot(t,var{2},'LineWidth',lineWidth);
plot(t,var{3},'LineWidth',lineWidth);
plot(t,var{4},'LineWidth',lineWidth);

ylabel_str = 'Heat transfer (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
my_xticks = 0:60*60:tEndSimul;
my_xticks_min_str = (my_xticks/60);
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])
%
legend('Q electrical\rightarrowthermal',...
       'Q heater\rightarrowreactor''s wall',...
       'Q heater\rightarrowambient',...
       'Q reactor''s wall\rightarrowcomposite',...
       'Location','southwest');

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{5},'LineWidth',lineWidth);
grid on;
hold on
plot(t,var{6},'LineWidth',lineWidth);
plot(t,var{7},'LineWidth',lineWidth);

ylabel_str = 'Temperature (°C)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])
%
legend('T heater',...
       'T reactor''s wall',...
       'T reactor',...
       'Location','northwest');

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{8},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Reactor pressure (bar)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{9},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Reaction advancement (0..1)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{12},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Total gas in reactor (mol)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{13},'LineWidth',lineWidth);
grid on;

ylabel_str = 'dN_g_a_s/dt (mol/sec)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
xlim([t(1) t(end)])

%%
% hfig = figure;
% Hfig = [Hfig hfig];
% plot(t,var{14},'LineWidth',lineWidth);
% grid on;
% 
% ylabel_str = 'Reaction phase';
% ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
% hfig.Children.FontSize = ticksFontSize;
% %
% hfig.Children.XTick = my_xticks;
% hfig.Children.XTickLabel = my_xticks_min_str;
% %
% xlim([t(1) t(end)])
 

%%
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.7 0.8];
    Hfig(i).CurrentAxes.XLim(1) = Hfig(i).CurrentAxes.XLim(1) + 10;
%     Hfig(i).CurrentAxes.Position = [0.1 0.075 0.85 0.85];
    Hfig(i).CurrentAxes.Position = [0.12 0.075 0.83 0.85];
    Hfig(i).CurrentAxes.XLabel.String = '(min)';
    Hfig(i).CurrentAxes.XLabel.FontSize = labelFontSize;
    Hfig(i).CurrentAxes.XLabel.FontWeight = 'bold';
    Hfig(i).CurrentAxes.XLabel.Units = 'normalized';
    Hfig(i).CurrentAxes.XLabel.Position = [1.024 0 0];
end

