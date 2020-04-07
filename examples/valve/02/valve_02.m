%% Cleanup
clearvars -except fluid valveLib
close all
clc

%% Parameters
c = conversion_factors();
if ~exist('fluid','var')
    load nh3_v4.mat;
    fluid = nh3_v4;
    clearvars nh3_v4
end
if ~exist('valveLib','var')
    load valveLib.mat;
end

%%
