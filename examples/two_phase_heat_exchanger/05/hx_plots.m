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
var_name_list = {'T water in (°C)',...              % 1
                 'T water out (°C)',...             % 2
                 'T water avg (°C)',...             % 3
                 'Tsat (°C)',...                    % 4
                 'Twall (°C)',...                   % 5
                 'P sat (bar)',...                  % 6
                 'dm/dt water (L/min)',...          % 7
                 'dn/dt water (mol/sec)',...        % 8
                 'dn/dt in (mol/sec)',...           % 9
                 'dn/dt vap, out (mol/sec)',...     % 10
                 'dn/dt liq, out (mol/sec)',...     % 11
                 'vapor quality (0..1)',...         % 12
                 'liquid fraction (0..1)',...       % 13
                 'q fluid > wall (W)',...           % 14
                 'q wall > water (W)'...            % 15
                 'epsilon',...                      % 16
                 'UA (W/K)',...                     % 17
                 'NTU',...                          % 18
                 };

% Variables vectors:
clear var
for i = 1:length(var_name_list)
    var{i} = logsout.getElement(var_name_list{i}).Values.Data;
end

% Time vector:
time_bias = tStart_dnDt_out_vap;
t = logsout{1}.Values.Time - time_bias;

% Array of figures
Hfig = [];

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{10},'LineWidth',lineWidth);
grid on;

ylabel_str = 'dn/dt_o_u_t (vapor)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
my_xticks = 0:2.5 * c.min_to_sec:tEndSimul;
my_xticks_min_str = (my_xticks/60);
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{1},'LineWidth',lineWidth);
grid on;
hold on
plot(t,var{5},'-','LineWidth',lineWidth);
plot(t,var{4},'-','LineWidth',lineWidth);
plot(t,var{2},'-','LineWidth',lineWidth);
plot(t,var{3},'-','LineWidth',lineWidth);

ylabel_str = 'Temperature (°C)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
legend('Water inlet',...
       'Wall',...
       'Condensing fluid',...
       'Water outlet',...
       'Water averaged',...
       'Location','northeast');
 
%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{13},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Volumetric liquid fraction (0..1)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{14},'LineWidth',lineWidth);
grid on;
hold on;
plot(t,var{15},'LineWidth',lineWidth);
%
ylabel_str = 'Heat transfer (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

legend('HX fluid\rightarrowHX wall',...
       'HX wall\rightarrowHX heat transfer fluid',...
       'Location','northeast');

%%
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{6},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Pressure (bar)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

%%
hfig = figure;
Hfig = [Hfig hfig];
semilogy(t,var{12},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Vapor quality \chi (0..1)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

%%
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.8 0.8];
    Hfig(i).CurrentAxes.XLim(1) = Hfig(i).CurrentAxes.XLim(1) + 10;
    Hfig(i).CurrentAxes.Position = [0.1 0.075 0.85 0.85];
    Hfig(i).CurrentAxes.XLabel.String = '(min)';
    Hfig(i).CurrentAxes.XLabel.FontSize = labelFontSize;
    Hfig(i).CurrentAxes.XLabel.FontWeight = 'bold';
    Hfig(i).CurrentAxes.XLabel.Units = 'normalized';
    Hfig(i).CurrentAxes.XLabel.Position = [1.024 0 0];
    Hfig(i).CurrentAxes.XLim = [t(1)/20 t(end)-5];
end

