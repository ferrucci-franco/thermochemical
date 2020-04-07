function [kg_tube, kg_fins, m2_inner, m2_outer] = blk_wall_finned_tube_fun1(OD_mm, e_mm, L_m, rho_tube, height_fin_mm, pitch_fin_mm, e_fin_mm, rho_fin)

% Conversion:
OD_m = OD_mm * 1e-3;
e_m = e_mm * 1e-3;
ID_m = OD_m - 2 * e_m;
height_fin_m = height_fin_mm * 1e-3;
pitch_fin_m = pitch_fin_mm * 1e-3;
e_fin_m = e_fin_mm * 1e-3;


% Volume of bare tube (m3):
tube_volume = pi/4*(OD_m^2 - ID_m^2)*L_m;

% Mass tube (kg):
kg_tube = tube_volume * rho_tube;

% Inner area (m2):
m2_inner = pi * ID_m * L_m;

% Verify if there is no fins:
if height_fin_mm == 0 || e_fin_mm == 0 || pitch_fin_mm == 0
    kg_fins = 0;
    m2_outer =  pi*OD_m*L_m;
else
    % One-side fin area (m2):
    fin_area_one_side = pi/4*((OD_m+height_fin_m)^2 - OD_m^2);

    % Fin area (m2):
    fin_area = 2 * fin_area_one_side + pi * (OD_m + height_fin_m) * e_fin_m;

    % Tube exposed area between two fins (m2):
    exposed_area_single = pi * OD_m * (pitch_fin_m - e_fin_m);

    % Volume of fin (m3):
    fin_volume = fin_area_one_side * e_fin_m;

    % Number of fins:
    N = floor(L_m/pitch_fin_m);

    % Mass fins (kg):
    kg_fins = fin_volume * N * rho_fin;

    % Outer area (m2):
    m2_outer = (fin_area + exposed_area_single) * N; 
end
