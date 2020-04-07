function y = heat_exchanger_epsilonNTU_inv_simulink(T1_in_K, P1_bar, dNdt_1_mol_sec, fluidName_1, T2_in_K, P2_bar, dNdt_2_mol_sec, fluidName_2, epsilon, flowType)
% Simulink wrapper of function 'heat_exchanger_epsilonNTU_inv' to use it in an
% interpreted Matlab function block (hint: the interpreted Matlab function
% block only accepts functions with a single Nx1 return variable).

% Function call:
[T1_out_K, T2_out_K, q, UA,NTU, Cr, fval] = heat_exchanger_epsilonNTU_inv(T1_in_K, P1_bar, dNdt_1_mol_sec, fluidName_1, T2_in_K, P2_bar, dNdt_2_mol_sec, fluidName_2, epsilon, flowType);

% Bundle output arguments into one variable 'y':
y = zeros(1,5);
y(1) = T1_out_K;
y(2) = T2_out_K;
y(3) = q;
y(4) = UA;
y(5) = NTU;
y(6) = Cr;
y(7) = fval;

end