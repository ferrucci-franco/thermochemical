clear
close all
clc
%
load valveLib.mat
%
labelFontSize = 20;
ticksFontSize = 20;
lineWidth = 4;
%
Cv = valveLib.Hoke.s2300.model_2335G4Y.Cv_vs_turns(:,2);
app = valveLib.Hoke.s2300.model_2335G4Y.Cv_vs_turns(:,1);
%
plot(Cv,app,'LineWidth',lineWidth);
grid on
%
xlabel_str = 'Cv';
xlabel(xlabel_str,'FontSize',labelFontSize,'FontWeight','bold');
ylabel_str = 'Number of turns';
ylabel(ylabel_str,'FontSize',labelFontSize,'FontWeight','bold');
%
ax = gca;
ax.FontSize = ticksFontSize;
xlim([0 0.28])
my_xticks = 0:0.04:0.28;
ax.XTick = my_xticks;
ax.XTickLabel = {'0','.04','.08','.12','.16','.20','.24','.28'};
my_yticks = 0:2:20;
ax.YTick = my_yticks;
%
