function y = blk_reactor_BaCl2_NH3_cylindrical_no_walls_fun1(x)
%%
% Salt molar mass:
pair = get_material_properties(x.pairName);
binder = get_material_properties(x.binderName);
gas = get_material_properties(x.gasName);

% Composite volume (m3):
y.Vcomposite_m3 = x.Lr * (pi/4*(x.D^2-x.Ddiff^2));

% Composite mass (kg):
y.m_composite_kg = x.rho_composite * y.Vcomposite_m3;

% Binder modified apparent density (kg binder/m3 composite):
y.rho_binder = x.rho_composite * (1 - x.tao_salt);

% Number of moles of salt:
y.N_salt = y.rho_binder * y.Vcomposite_m3 * x.tao_salt / (1-x.tao_salt) / pair.M_salt;

% Reactor volume:
y.Vreactor_m3 = x.Lr_total * pi/4*x.D^2; % (m3)
y.Vreactor_litre = y.Vreactor_m3 * 1000; % (litre)

% Void volume (m3):
y.Vvoid_m3 = y.Vreactor_m3 - y.Vcomposite_m3;

% Binder mass (kg):
y.m_binder_kg = y.rho_binder * y.Vcomposite_m3;

% Salt mass (kg)
y.m_salt_kg = y.m_composite_kg - y.m_binder_kg;

% Mass of gas when reactor is fully charged (kg):
y.m_gas_kg = y.N_salt * pair.nu * pair.M_gas;

% Moles of salt (mol):
y.N_salt = y.m_salt_kg/pair.M_salt;

% Moles of binder (mol):
y.N_binder = y.m_binder_kg/binder.M;

% Estimated cold production during synthesis (kWh):
con = conversion_factors(); % load conversion factor table
y.kWh_cold = y.m_gas_kg * gas.dh / gas.M * con.J_to_kWh;

% Computation of initial number of moles of gas in the void volume 
% (assuming ideal gas approximation):
Pr_init = clausius_clapeyron(x.Tr_init, 'K', 'Pa', 'BaCl2-NH3'); % initial equilibrium pressure
R = 8.314472;
y.N_gas_free_volume_init = Pr_init * y.Vvoid_m3 / x.Tr_init / R;
