%%
close all
clc

%% Desorption time
% Time vector:
% t = logsout{1}.Values.Time - T1;
t = tout - T1;
%
idx_T0 = find(t > motor_start_time_sec-T1, 1);
idx_T1 = find(t > 0,1);

% Desorption time between T1 and end of simulation:
tDesorp = t(end) - t(idx_T1);
tDesorp_miniute = tDesorp * c.sec_to_min;

% Generate random number for plot:
this_plot_code = round(1e4*rand(1));

%% Performance indices computation
X = logsout.getElement('X').Values.Data;

% dX between T1 and end of simulation:
dX = X(idx_T1)-X(end);

AVG_dnDt = logsout.getElement('AVG{dn/dt (mol/sec)}').Values.Data(end);
AVG_Qdesorp = logsout.getElement('AVG{Q ambient to wall (W)}').Values.Data(end);
AVG_Qcond = logsout.getElement('AVG{q wall > water (W)}').Values.Data(end);
AVG_Qsubcool = logsout.getElement('AVG{Q reservoir wall > outer (W)}').Values.Data(end);
AVG_compr_ratio = logsout.getElement('AVG{compresssion_ratio}').Values.Data(end);
AVG_Tdisch_C = logsout.getElement('AVG{T discharge (°C)}').Values.Data(end);
AVG_Tdesorp_C = logsout.getElement('AVG{Tr (°C)}').Values.Data(end);
AVG_dW_electr = logsout.getElement('AVG{P elec: U x I (W)}').Values.Data(end);
AVG_dW_compr = logsout.getElement('AVG{T x w load (W)}').Values.Data(end);
AVG_Tin2ndStage_C = logsout.getElement('AVG{T in 2nd stage (°C)}').Values.Data(end);
AVG_Tout1stStage_C = logsout.getElement('AVG{T out 1st stage (°C)}').Values.Data(end);
AVG_Tcompr_water_out_C = logsout.getElement('AVG{T compr. water out (°C)}').Values.Data(end);
AVG_w_rmp = logsout.getElement('AVG{w (rpm)}').Values.Data(end);
AVG_Tsat = logsout.getElement('AVG{T hx,sat (°C)}').Values.Data(end);
AVG_Pcond = logsout.getElement('AVG{Pr cond sat. (bar)}').Values.Data(end);
AVG_Pr = logsout.getElement('AVG{Pr reactor (bar)}').Values.Data(end);
%
INT_dnDt = logsout.getElement('int{dn/dt (mol/sec)}').Values.Data(end);
INT_Qdesorp = logsout.getElement('int{Q ambient to wall (W)}').Values.Data(end);
INT_Qcond = logsout.getElement('int{q wall > water (W)}').Values.Data(end);
INT_Qsubcool = logsout.getElement('int{Q reservoir wall > outer (W)}').Values.Data(end);
INT_dW_electr = logsout.getElement('int{P elec: U x I (W)}').Values.Data(end);
INT_dW_compr = logsout.getElement('int{T x w load (W)}').Values.Data(end);

% Array of axes:
Ax = [];

%% Plots
labelFontSize = 12;
ticksFontSize = 12;
lineWidth = 2;
%
my_xticks = 0:60*c.min_to_sec:t(end);
my_xticks_min_str = (my_xticks/60);
%----
subplot(231),plot(t,logsout.getElement('T discharge (°C)').Values.Data);
Ax = [Ax gca];
hold on;
grid on;
plot(t,logsout.getElement('T in 2nd stage (°C)').Values.Data);
plot(t,logsout.getElement('T out 1st stage (°C)').Values.Data);
title_str = 'T disch, Tin 2nd stage, Tout 1st stage (°C)';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_Tdisch_C),' °C'];
xlabel(xlabel_str);
%----
subplot(234),plot(t,logsout.getElement('Pr cond sat. (bar)').Values.Data./...
                     logsout.getElement('Pr reactor (bar)').Values.Data);
Ax = [Ax gca];
hold on;
grid on;
plot(t,logsout.getElement('Pr reactor (bar)').Values.Data);
plot(t,logsout.getElement('P_reactor_equilb (bar)').Values.Data);
    
title_str = 'Compr. ratio';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_compr_ratio)];
xlabel(xlabel_str);
%----
subplot(232), plot(t,logsout.getElement('T desorp,source (°C)').Values.Data);
Ax = [Ax gca];
hold on;
grid on;
plot(t,logsout.getElement('Tr (°C)').Values.Data);
plot(t,logsout.getElement('Tr,wall (°C)').Values.Data);
title_str = 'T reactor (°C)';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_Tdesorp_C),' °C'];
xlabel(xlabel_str);
%----
subplot(235), hold on, plot(t,logsout.getElement('dn/dt (mol/sec)').Values.Data,'LineWidth',lineWidth);
Ax = [Ax gca];
hold on;
grid on;
title_str = 'dn/dt (mol/sec) - w (rpm)';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_dnDt),' mol/sec, ',...
              'int = ',num2str(INT_dnDt),' mol'];
xlabel(xlabel_str);

yyaxis right
subplot(235),plot(t,logsout.getElement('w (rpm)').Values.Data,'LineWidth',lineWidth);

%----
subplot(233), hold on, plot(t,logsout.getElement('Q ambient to wall (W)').Values.Data);
Ax = [Ax gca];
hold on;
grid on;
title_str = 'Q desorption (W)';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_Qdesorp),' W, ',...
              'int = ',num2str(INT_Qdesorp),' J'];
xlabel(xlabel_str);
%----
subplot(236), hold on, plot(t,logsout.getElement('q wall > water (W)').Values.Data+...
                              logsout.getElement('Q reservoir wall > outer (W)').Values.Data);
Ax = [Ax gca];
hold on;
grid on;
title_str = 'Q cond (W)';
title(title_str,'FontSize',labelFontSize,'FontWeight','bold');
xlabel_str = ['AVG = ',num2str(AVG_Qcond+AVG_Qsubcool),' W, ',...
              'int = ',num2str(INT_Qcond+INT_Qsubcool),' J'];
xlabel(xlabel_str);

%% Plot enhancement
for i = 1:length(Ax)
	ax = Ax(i);
	ax.FontSize = ticksFontSize;
    ax.XTick = my_xticks;
    ax.XTickLabel = my_xticks_min_str;
    ax.XLabel.FontWeight = 'bold';
    ax.XLim = [0 t(end)];
    for j=1:length(ax.Children)
        ax.Children(j).LineWidth = lineWidth;
    end
end
figureFullScreen(gcf);
title_str = [' Plot code = ', num2str(this_plot_code),'      ',...
             'h = ',num2str(h_reactor_air),' W/m^2/K,       Ngalettes = ',...
             num2str(param.Lr/(46.5*c.mm_to_m)),',       Tdisch ref = ',...
             num2str(Tdisch_ref_C),'°C ,       Tdesorp = ',...
             num2str(Tdesorp_source_C),' °C,     \DeltaX = ',...
             num2str(dX),'       \DeltaT = ',...
             num2str(tDesorp), 'sec. (',num2str(round(tDesorp/60)),' min.)'];
suptitle(title_str);

%%

COP_2_3 = INT_dnDt * c.M_NH3 * 0.3506 / (INT_dW_electr * c.J_to_kWh);
COP_total = INT_dnDt * c.M_NH3 * 0.3506 / ((INT_dW_electr + INT_Qdesorp) * c.J_to_kWh);
kWh_cold_per_hour = INT_dnDt * c.M_NH3 * 0.3506 / (tDesorp * c.sec_to_h);

%%   
disp(['Plot code           =',9, num2str(this_plot_code),9])
disp(['h                   =',9, num2str(h_reactor_air),9,'W/m2/K'])
disp(['Tdisch ref          =',9, num2str(Tdisch_ref_C),9,'°C'])
disp(['Ngalettes           =',9, num2str(param.Lr/(46.5*c.mm_to_m))])
disp(['Tdesorp (source)    =',9, num2str(Tdesorp_source_C),9,'°C'])
disp(['Kcin                =',9, num2str(K_cin),9,'1/sec'])
disp('--')
disp(['dX                  =',9, num2str(dX)])
disp(['dT                  =',9, num2str(tDesorp),9,'sec'])
disp(['dX/dT               =',9, num2str(dX/tDesorp),9,'1/sec'])
disp(['avg(Tdesorp)        =',9, num2str(AVG_Tdesorp_C),9,'°C'])
disp(['avg(dn/dt)          =',9, num2str(AVG_dnDt),9,'mol/sec'])
disp(['int(dn/dt)          =',9, num2str(INT_dnDt),9,'mol'])
disp(['avg(Qdesorp)        =',9, num2str(AVG_Qdesorp),9,'W'])
disp(['int(Qdesorp)        =',9, num2str(INT_Qdesorp),9,'J'])
disp(['avg(Qcond)          =',9, num2str(AVG_Qcond+AVG_Qsubcool),9,'W'])
disp(['int(Qcond)          =',9, num2str(INT_Qcond+INT_Qsubcool),9,'J'])
disp(['avg(Pow electr.)    =',9, num2str(AVG_dW_electr),9,'W'])
disp(['int(Pow electr.)    =',9, num2str(INT_dW_electr),9,'J'])
disp(['avg(Pow compr)      =',9, num2str(AVG_dW_compr),9,'W'])
disp(['int(Pow compr)      =',9, num2str(INT_dW_compr),9,'J'])
disp(['avg(Tdisch)         =',9, num2str(AVG_Tdisch_C),9,'°C'])
disp(['avg(Tin2ndStage)    =',9, num2str(AVG_Tin2ndStage_C),9,'°C'])
disp(['avg(Tout1stStage)   =',9, num2str(AVG_Tout1stStage_C),9,'°C'])
disp(['avg(TcomprWaterOut) =',9, num2str(AVG_Tcompr_water_out_C),9,'°C'])
disp(['Tdisch MAX          =',9, num2str(max(logsout.getElement('T discharge (°C)').Values.Data)),9,'°C'])
disp(['avg(compr ratio)    =',9, num2str(AVG_compr_ratio)])
disp(['avg(w)              =',9, num2str(AVG_w_rmp),9,'rpm'])
disp(['avg(Tsat)           =',9, num2str(AVG_Tsat),9,'°C'])
disp(['avg(Pcond)          =',9, num2str(AVG_Pcond),9,'bar'])
disp(['avg(Pr)             =',9, num2str(AVG_Pr),9,'bar'])
disp(['Kp                  =',9, num2str(PID_P_Tdisch),9,' '])
disp(['Ki                  =',9, num2str(PID_I_Tdisch),9,' '])
% disp(['Kd                  =',9, num2str(PID_D_Tdisch),9,' '])
disp('--')
disp(['COP 2-3             =',9, num2str(COP_2_3),9,' '])
disp(['COP total           =',9, num2str(COP_total),9,' '])
disp(['dX/dT (%/hour)      =',9, num2str(dX*100/(tDesorp*c.sec_to_h)),9,'%/hour'])
disp(['kWhcold/h           =',9, num2str(kWh_cold_per_hour),9,'kWhcold/hour'])
disp('-------------------------------------------------')
