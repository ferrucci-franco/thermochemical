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
var_name_list = {'w ref (rpm)',...                      % 1
                 'w (rpm)',...                          % 2
                 'P available (W)',...                  % 3
                 'P elec: U x I (W)',...                % 4
                 'T x w motor (W)',...                  % 5
                 'T x w load (W)',...                   % 6
                 'P compr. irrev (W)',...               % 7
                 'T discharge (°C)',...                 % 8
                 'dn/dt (mol/sec)',...                  % 9
                 'T desorp,source (°C)',...             % 10
                 'Tr,wall (°C)',...                     % 11
                 'Tr (°C)',...                          % 12
                 'Pr reactor (bar)',...                 % 13
                 'phase',...                            % 14
                 'X',...                                % 15
                 'Q wall to composite (W)',...          % 16
                 'int{Q wall to composite} (J)',...     % 17
                 'Q ambient to wall (W)',...            % 18
                 'int{Q ambient to wall} (J)',...       % 19
                 'T hx,water in (°C)',...               % 20
                 'dV/dt water (L/min)',...              % 21
                 'T water out (°C)',...                 % 22
                 'epsilon',...                          % 23
                 'NTU',...                              % 24
                 'UA (W/K)',...                         % 25
                 'Pr cond sat. (bar)',...               % 26
                 'T hx,sat (°C)',...                    % 27
                 'T hx,wall (°C)',...                   % 28
                 'vapor quality (0..1)',...             % 29
                 'liquid fraction (0..1)',...           % 30
                 'q fluid > wall (W)',...               % 31
                 'q wall > water (W)',...               % 32
                 'T water avg (°C)',...                 % 33
                 'U motor (V)',...                      % 34
                 'I motor (A)',...                      % 35
                 'Clamp',...                            % 36
                 'Tamb (°C)',...                        % 37
                 'Pr reservoir sat (bar)',...           % 38
                 'T reservoir sat (°C)',...             % 39
                 'T reservoir wall (°C)',...            % 40
                 'reservoir vapor quality (0..1)',...   % 41
                 'reservoir liquid fraction (0..1)',... % 42
                 'reservoir liquid level (m)',...       % 43
                 'Q reservoir inner > wall (W)',...     % 44
                 'Q reservoir wall > outer (W)',...     % 45
                 'dn/dt liq, out (mol/sec)',...         % 46
                 'P_reactor_equilb (bar)',...           % 47
                 };                          

% Variables vectors:
clear var
for i = 1:length(var_name_list)
    var{i} = logsout.getElement(var_name_list{i}).Values.Data;
end

% Time vector:
time_bias = rpm_ref_01_time;
t = logsout{1}.Values.Time - time_bias;

my_xticks = 0:30*c.min_to_sec:tEndSimul;
my_xticks_min_str = (my_xticks/60);

% Array of figures
Hfig = [];

%% Q
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{18},'LineWidth',lineWidth);      % 'Q ambient to wall (W)'
grid on;
hold on;
% plot(t,var{16},'LineWidth',lineWidth);      % 'Q wall to composite (W)'
% plot(t,var{31},'LineWidth',lineWidth);      % 'q fluid > wall (W)'
plot(t,var{32},'LineWidth',lineWidth);      % 'q wall > water (W)'
% plot(t,var{44},'LineWidth',lineWidth);      % 'Q reservoir inner > wall (W)'
% plot(t,var{45},'LineWidth',lineWidth);      % 'Q reservoir wall > outer (W)'

ylabel_str = 'Heat transfer (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

ylim([-20 560])
%
legend('Ambient\rightarrowReactor',...
       'Condenser\rightarrowWater loop',...
       'Location','northeast');

%% Temperature Reactor
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{10},'LineWidth',lineWidth);      % 
grid on;
hold on;
plot(t,var{11},'LineWidth',lineWidth);      % 
plot(t,var{12},'LineWidth',lineWidth);      % 

ylabel_str = 'Temperature (°C)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
%
legend('Desorp.,source',...
       'Reactor wall',...
       'Reactor',...
       'Location','southeast');
ylim([26 40.5])

%% Temperature condenser
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{20},'LineWidth',lineWidth);      % 'T hx,water in (°C)'
grid on;
hold on;
plot(t,var{22},'LineWidth',lineWidth);      % 'T water out (°C)'
plot(t,var{27},'LineWidth',lineWidth);      % 'T hx,sat (°C)'
% plot(t,var{28},'LineWidth',lineWidth);      % 'T hx,wall (°C)'
% plot(t,var{37},'LineWidth',lineWidth);      % 'Tamb (°C)'
plot(t,var{39},'LineWidth',lineWidth);      % 'T reservoir sat (°C)'
% plot(t,var{40},'LineWidth',lineWidth);      % 'T reservoir wall (°C)'
% plot(t,var{33},'LineWidth',lineWidth);      % 'T water avg (°C)'

ylabel_str = 'Temperature (°C)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;

legend('Condenser, water inlet (=T_a_m_b)',...
       'Condenser, water outlet',...
       'Condenser, NH_3',...
       'Reservoir',...
       'Location','northeast');
ylim([24.75 30.75])

%% Pressure 
hfig = figure;
Hfig = [Hfig hfig];
% yyaxis left
plot(t,var{26},'-','Color',[0.000 0.447 0.741],'LineWidth',lineWidth);
grid on;
hold on;
plot(t,var{13},'-','Color',[0.850 0.325 0.098],'LineWidth',lineWidth);
plot(t,var{47},'-','Color',[0.494 0.184 0.556],'LineWidth',lineWidth);
ylabel_str = 'Pressure (bar)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
yyaxis right
plot(t,var{26}./var{13},'-.','Color',[0.301 0.745 0.933],'LineWidth',lineWidth);
hfig.Children.YColor = [0.301 0.745 0.933];
ylabel_str = 'Pressure ratio';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
hfig.Children.FontSize = ticksFontSize;
legend('P condenser',...
       'P reactor',...
       'P equilibr. at T_r_e_a_c_t_o_r',...
       'Pressure ratio',...
       'Location','best');
   
%% X
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{15},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Reaction advancement (0..1)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
ylim([0.05 1])

%% Tdisch
hfig = figure;
Hfig = [Hfig hfig];
plot(t,var{8},'LineWidth',lineWidth);
grid on;

ylabel_str = 'Compressor discharge temperature (°C)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
%
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
ylim([20 210])

%% Speed, dn/dt
hfig = figure;
Hfig = [Hfig hfig];
%
yyaxis right
plot(t,var{9},'LineWidth',lineWidth);
grid on;
ylabel_str = 'Mass flow rate (mol/sec)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.YAxis(2).Exponent = -3;
%
yyaxis left
plot(t,var{2},'LineWidth',lineWidth);
grid on;
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
ylabel_str = 'Motor speed (rpm)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;

%% Compressor power
hfig = figure;
Hfig = [Hfig hfig];
%
plot(t,var{4},'LineWidth',lineWidth);       % 'P elec: U x I (W)'
grid on;
hold on;
plot(t,var{7},'LineWidth',lineWidth);       % 'P compr. irrev (W)' 
ylabel_str = 'Compressor power (W)';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
hfig.Children.FontSize = ticksFontSize;
hfig.Children.XTick = my_xticks;
hfig.Children.XTickLabel = my_xticks_min_str;
legend('Electrical power',...
       '\Deltah_i_r_r_e_v x dn/dt',...
       'Location','northeast');

%%
for i = 1:length(Hfig)
    Hfig(i).Units = 'normalized';
    Hfig(i).Position = [0.1 0.1 0.7 0.8];
    Hfig(i).CurrentAxes.XLim(1) = Hfig(i).CurrentAxes.XLim(1) + 10;
    Hfig(i).CurrentAxes.Position = [0.09 0.075 0.83 0.85];
    Hfig(i).CurrentAxes.XLabel.String = '(min)';
    Hfig(i).CurrentAxes.XLabel.FontSize = labelFontSize;
    Hfig(i).CurrentAxes.XLabel.FontWeight = 'bold';
    Hfig(i).CurrentAxes.XLabel.Units = 'normalized';
    Hfig(i).CurrentAxes.XLabel.Position = [1.024 -0.015 0];
    Hfig(i).CurrentAxes.XLim = [-10*c.min_to_sec t(end)-1*c.min_to_sec];
end

