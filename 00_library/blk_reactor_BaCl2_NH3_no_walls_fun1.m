function y = blk_reactor_BaCl2_NH3_no_walls_fun1(x)

% Get pair and binder properties:
pair = get_material_properties(x.pairName);
binder = get_material_properties(x.binderName);

% Salt mass (kg)
y.m_salt_kg = x.N_salt * pair.M_salt;

% Binder mass (kg):
y.m_binder_kg = x.N_binder * binder.M;

% Composite mass (kg):
y.m_composite_kg = y.m_salt_kg + y.m_binder_kg;

% Mass of gas when reactor is fully charged (kg):
y.m_gas_kg = x.N_salt * pair.nu * pair.M_gas;

% Set variables according to pair and binder properties:
y.cP_s0 = pair.cp_salt;
y.nu = pair.nu;
y.cP_gas = pair.cp_gas;
y.cP_binder = binder.cp;
y.M_binder = binder.M;
y.Pr_0 = pair.Pref_r;
y.dh_r_0 = pair.dh_r;
y.ds_r_0 = pair.ds_r;

