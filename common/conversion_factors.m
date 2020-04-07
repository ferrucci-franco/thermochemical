function con = conversion_factors()
%% Conversion factors

% All the conversion factors and functions are inside a structure
% named 'con' (from 'convertion').

% Franco Ferrucci
% ferruccifranco@gmail.com
% Jan 2018

%% Pressure:
con.Pa_to_kPa   = 1e-3;
con.kPa_to_Pa   = 1e+3;
con.bar_to_Pa   = 1e5;
con.Pa_to_bar   = 1/con.bar_to_Pa;
con.bar_to_psi  = 14.5038;
con.psi_to_bar  = 1/con.bar_to_psi;
con.Pa_to_psi   = con.Pa_to_bar*con.bar_to_psi;
con.psi_to_Pa   = 1/con.Pa_to_psi;
con.psi_to_kPa  = con.psi_to_Pa * con.Pa_to_kPa;
con.kPa_to_psi  = 1/con.psi_to_kPa;
con.atm_to_bar  = 1.0132501;
con.bar_to_atm  = 1/con.atm_to_bar;
con.bar_to_kPa  = con.bar_to_Pa * con.Pa_to_kPa;
con.kPa_to_bar  = 1/con.bar_to_kPa;
con.atm_to_Pa   = con.atm_to_bar * con.bar_to_Pa;
con.Pa_to_atm   = 1/con.atm_to_Pa;
con.atm_to_kPa  = con.atm_to_Pa * con.Pa_to_kPa;
con.kPa_to_atm  = 1/con.atm_to_kPa;
con.psi_to_atm  = con.psi_to_bar * con.bar_to_atm;
con.atm_to_psi  = 1/con.psi_to_atm;
con.mmHg_to_Pa  = 133.322387415;
con.Pa_to_mmHg  = 1/con.mmHg_to_Pa;
con.mmHg_to_kPa = con.mmHg_to_Pa * con.Pa_to_kPa;
con.kPa_to_mmHg = 1/con.mmHg_to_kPa;
con.bar_to_mmHg = con.bar_to_Pa * con.Pa_to_mmHg;
con.mmHg_to_bar = 1/con.bar_to_mmHg;
con.atm_to_mmHg = con.atm_to_Pa * con.Pa_to_mmHg;
con.mmHg_to_atm = 1/con.atm_to_mmHg;
con.psi_to_mmHg = con.psi_to_Pa * con.Pa_to_mmHg;
con.mmHg_to_psi = 1/con.psi_to_mmHg;
con.bar_to_mH2O = 10.19716213;
con.mH2O_to_bar = 1/con.bar_to_mH2O;
con.psi_to_mH2O = con.psi_to_bar * con.bar_to_mH2O;
con.mH2O_to_psi = 1/con.psi_to_mH2O;

%% Temperature
% We need functions as the conversion is not just a multiplying factor.
con.Tk = 273.15;
con.K_to_C = @(x) x - con.Tk;
con.C_to_K = @(x) x + con.Tk;
con.C_to_F = @(x) x * 9/5 + 32;
con.F_to_C = @(x) 5/9*(x - 32);
con.K_to_F = @(x) con.C_to_F(con.K_to_C(x));
con.F_to_K = @(x) con.C_to_K(con.F_to_C(x));

%% Length:
con.m_to_ft  = 3.28084;
con.ft_to_m  = 1/con.m_to_ft;
con.in_to_mm = 25.4;
con.mm_to_in = 1/con.in_to_mm;
con.in_to_m  = con.in_to_mm / 1000;
con.m_to_in  = 1/con.in_to_m;
con.mm_to_m  = 1e-3;
con.m_to_mm  = 1/con.mm_to_m;
con.m_to_km  = 1e-3;
con.km_to_m  = 1/con.m_to_km;

%% Surface:
con.m2_to_ft2 = con.m_to_ft^2;
con.ft2_to_m2 = 1/con.m2_to_ft2;
con.in2_to_m2 = con.in_to_m^2;

%% Volume:
con.m3_to_L      = 1e3;
con.L_to_m3      = 1/con.m3_to_L;

con.galUS_to_L   = 3.785411784;
con.L_to_galUS   = 1/con.galUS_to_L;

con.galUK_to_L   = 4.54609;
con.L_to_galUK   = 1/con.galUK_to_L;

con.galUS_to_m3  = con.galUS_to_L * con.L_to_m3; 
con.m3_to_galUS  = 1/con.galUS_to_m3;

con.galUK_to_m3  = con.galUK_to_L * con.L_to_m3;
con.m3_to_galUK  = 1/con.galUK_to_m3;

con.ozUS_to_m3   = con.galUS_to_m3 / 128;
con.m3_to_ozUS   = 1/con.ozUS_to_m3;

con.ozUS_to_L    = con.galUS_to_L / 128;
con.L_to_ozUS    = 1/con.ozUS_to_L;

con.ft3_to_m3    = (con.ft_to_m)^3;
con.m3_to_ft3    = 1/con.ft3_to_m3;

con.L_to_ft3     = con.L_to_m3 * con.m3_to_ft3;
con.ft3_to_L     = 1/con.L_to_ft3;

%% Time
con.sec_to_min  = 1/60;
con.min_to_sec  = 1/con.sec_to_min;

con.min_to_h    = 1/60;
con.h_to_min    = 1/con.min_to_h;

con.sec_to_h    = 1/3600;
con.h_to_sec    = 1/con.sec_to_h;

con.h_to_yr     = 1/(24*365); 
con.yr_to_h     = 1/con.h_to_yr;

%% Volume flow rate:
con.m3_sec_to_L_min  = 1000*60;
con.L_min_to_m3_sec  = 1/con.m3_sec_to_L_min;

con.m3_h_to_L_min    = 1000/60;
con.L_min_to_m3_h    = 1/con.m3_h_to_L_min;

con.m3_h_to_m3_sec   = 1/3600;
con.m3_sec_to_m3_h   = 1/con.m3_h_to_m3_sec;

con.m3_sec_to_gpmUS  = con.m3_to_galUS*60;
con.gpmUS_to_m3_sec  = 1/con.m3_sec_to_gpmUS;

con.L_min_to_gpmUS   = con.L_to_galUS;
con.gpmUS_to_L_min   = 1/con.L_min_to_gpmUS;

con.gpmUS_to_m3_h    = con.gpmUS_to_m3_sec * con.m3_sec_to_m3_h;
con.m3_h_to_gpmUS    = 1/con.gpmUS_to_m3_h;

con.m3_sec_to_CFH    = con.m3_to_ft3 / con.sec_to_h;
con.CFH_to_m3_sec    = 1/con.m3_sec_to_CFH;

con.m3_sec_to_CFM    = con.m3_to_ft3 / con.sec_to_min;
con.CFM_to_m3_sec    = 1/con.m3_sec_to_CFM;

con.L_min_to_CFH     = con.L_to_ft3 / con.min_to_h;
con.CFH_to_L_min     = 1/con.L_min_to_CFH;

con.L_min_to_CFM     = con.L_to_ft3;
con.CFM_to_L_min     = 1/con.L_min_to_CFM;

con.m3_h_to_CFM      = con.m3_to_ft3 / con.h_to_min;
con.CFM_to_m3_h      = 1/con.m3_h_to_CFM;

con.gpmUS_to_CFH     = con.galUS_to_m3 * con.m3_to_ft3 / con.min_to_h;
con.CFH_to_gpmUS     = 1/con.gpmUS_to_CFH;

con.gpmUS_to_CFM     = con.galUS_to_m3 * con.m3_to_ft3;
con.CFM_to_gpmUS     = 1/con.gpmUS_to_CFM;

con.CFH_to_m3_sec    = con.ft3_to_m3 / con.h_to_sec;
con.m3_sec_to_CFH    = 1/con.CFH_to_m3_sec;

con.CFH_to_m3_h      = con.ft3_to_m3;
con.m3_h_to_CFH      = 1/con.CFH_to_m3_h;

con.CFH_to_L_min     = con.ft3_to_L / con.h_to_min;
con.L_min_to_CFH     = 1/con.CFH_to_L_min;

con.CFH_to_gpmUS     = con.ft3_to_m3 * con.m3_to_galUS / con.h_to_min;
con.gpmUS_to_CFH     = 1/con.CFH_to_gpmUS;

con.CFH_to_CFM       = 1/con.h_to_min;
con.CFM_to_CFH       = 1/con.CFH_to_CFM;

con.CFM_to_m3_h      = con.ft3_to_m3 / con.min_to_h;
con.m3_h_to_CFM      = 1/con.CFM_to_m3_h;

con.CFM_to_L_min     = con.ft3_to_L;
con.L_min_to_CFM     = 1/con.CFM_to_L_min;

con.CFM_to_gpmUS     = con.ft3_to_m3 * con.m3_to_galUS;
con.gpmUS_to_CFM     = 1/con.CFM_to_gpmUS;

con.CFM_to_CFH       = 1/con.min_to_h;
con.CFH_to_CFM       = 1/con.CFM_to_CFH;

%% Velocity:
con.m_sec_to_km_h = con.m_to_km / con.sec_to_h;
con.km_h_to_m_sec = 1/con.m_sec_to_km_h;

%% Energy
con.J_to_Wh     = 1/3600;
con.J_to_kWh    = con.J_to_Wh / 1000;
con.Wh_to_J     = 1/con.J_to_Wh;
con.kJ_to_kWh   = con.J_to_Wh;
con.kWh_to_kJ   = 1/con.kJ_to_kWh;
con.kJ_to_Wh    = 1000 * con.J_to_Wh;
con.Wh_to_kJ    = 1/con.kJ_to_Wh;
con.cal_to_J    = 4.184;
con.J_to_cal    = 1/con.cal_to_J;
con.kcal_to_J   = con.cal_to_J * 1e3;
con.J_to_kcal   = 1/con.kcal_to_J;
con.cal15_to_J  = 4.1855;
con.J_to_cal15  = 1/con.cal15_to_J;
con.BTU_to_J    = 1055.06;
con.J_to_BTU    = 1/con.BTU_to_J;

%% Power
con.BTUh_to_W = con.BTU_to_J / 3600;
con.W_to_BTUh = 1/con.BTUh_to_W;

%% Rotational speed
con.rpm_to_rad_sec = 2*pi/60;
con.rad_sec_to_rpm = 1/con.rpm_to_rad_sec;

con.rpm_to_rev_sec = 1/60;
con.rev_sec_to_rpm = 1/con.rpm_to_rev_sec;

con.rad_sec_to_rev_sec = 1/(2*pi);
con.rev_sec_to_rad_sec = 1/con.rad_sec_to_rev_sec;

%% Mass
con.lb_to_kg = 0.453592;
con.kg_to_lb = 1/con.lb_to_kg;

con.kg_to_g  = 1e3;
con.g_to_kg  = 1/con.kg_to_g;

%% Valve flow coefficient
% NOTE: Kv in m3/h
con.Cv_to_Kv = con.gpmUS_to_m3_h/sqrt(con.psi_to_bar);
con.Kv_to_Cv = 1/con.Cv_to_Kv;

%% Constants
con.R = 8.314472; % [J/K/mol] universal gas constant
con.M_NH3 = 0.01703026; % NH3, kg/mole
